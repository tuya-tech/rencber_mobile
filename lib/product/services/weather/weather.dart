import 'package:dio/dio.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/models/weather/weather_response.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_mixin.dart';
import 'package:rencber_mobile/product/services/_dio_manager/services_path.dart';

class WeatherApiService {
  WeatherApiService._();
  static final instance = WeatherApiService._();

  Future<BaseResponseModel<WeatherResponseModel>> get(int fieldId) async {
    try {
      final response = await DioManager.dio.get(
        "${ServicesPath.instance.weather}/$fieldId",
        options: await DioManager.getOptions(),
      );

      if (response.statusCode == 200) {
        return BaseResponseModel<WeatherResponseModel>(
          data: WeatherResponseModel.fromJson(response.data),
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      } else {
        return BaseResponseModel<WeatherResponseModel>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return DioManager.dioError<WeatherResponseModel>(e);
    }
  }
}
