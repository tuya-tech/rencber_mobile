import 'package:dio/dio.dart';
import 'package:rencber_mobile/core/controller/exception.dart';
import 'package:rencber_mobile/product/models/_global/city.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_mixin.dart';
import 'package:rencber_mobile/product/services/_dio_manager/services_path.dart';

class LocationApiService {
  LocationApiService._();
  static final instance = LocationApiService._();

  Future<BaseResponseModel<List<CityModel>>> cityGet() async {
    try {
      final response = await DioManager.dio.get(
        ServicesPath.instance.city,
        //options: await DioManager.getOptions(),
      );

      if (response.statusCode == 200) {
        return BaseResponseModel<List<CityModel>>(
          data: (response.data as List).map((e) => CityModel.fromJson(e)).toList(),
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      } else {
        return BaseResponseModel<List<CityModel>>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      // Backend'den gelen hata kodunu işle
      String? errorCode = e.response?.data?['code'];
      String errorMessage = errorCode != null 
          ? ExceptionHandler.handleException(errorCode)
          : "Şehir verileri alınamadı";
      
      return BaseResponseModel<List<CityModel>>(
        data: null,
        message: errorMessage,
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }

  Future<BaseResponseModel<List<CityModel>>> districtGet(int cityId) async {
    try {
      final response = await DioManager.dio.get(
        "${ServicesPath.instance.district}/$cityId",
        //options: await DioManager.getOptions(),
      );

      if (response.statusCode == 200) {
        return BaseResponseModel<List<CityModel>>(
          data: (response.data as List).map((e) => CityModel.fromJson(e)).toList(),
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      } else {
        return BaseResponseModel<List<CityModel>>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      // Backend'den gelen hata kodunu işle
      String? errorCode = e.response?.data?['code'];
      String errorMessage = errorCode != null 
          ? ExceptionHandler.handleException(errorCode)
          : "İlçe verileri alınamadı";
      
      return BaseResponseModel<List<CityModel>>(
        data: null,
        message: errorMessage,
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }
}
