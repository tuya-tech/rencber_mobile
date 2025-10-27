import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rencber_mobile/core/cache/secure_storage.dart';
import 'package:rencber_mobile/core/controller/exception.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/models/weather/weather_response.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_mixin.dart';
import 'package:rencber_mobile/product/services/_dio_manager/services_path.dart';

class WeatherApiService {
  WeatherApiService._();
  static final instance = WeatherApiService._();

  Future<BaseResponseModel<WeatherResponseModel>> get() async {
    try {
      var fieldData = await SecureStorage.instance.readFieldModel('outLineField');
      var fieldId = fieldData?.id;
      final response = await DioManager.dio.get(
        "${ServicesPath.instance.weather}/field/$fieldId/live",
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
      debugPrint("DioException in WeatherApiService: ${e.response?.data}");
      
      // Backend'den gelen hata kodunu işle
      String? errorCode = e.response?.data?['code'];
      String errorMessage = errorCode != null 
          ? ExceptionHandler.handleException(errorCode)
          : "Hava durumu bilgisi alınamadı";
      
      return BaseResponseModel<WeatherResponseModel>(
        data: null,
        message: errorMessage,
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }

  Future<BaseResponseModel<List<WeatherResponseModel>>> getAll() async {
    try {
      var fieldData = await SecureStorage.instance.readFieldModel('outLineField');
      var fieldId = fieldData?.id ?? 0;
      final response = await DioManager.dio.get(
        //"${ServicesPath.instance.weather}/field/55/all",
        "${ServicesPath.instance.weather}/field/$fieldId/all",
        options: await DioManager.getOptions(),
      );

      if (response.statusCode == 200) {
        return BaseResponseModel<List<WeatherResponseModel>>(
          data: List<WeatherResponseModel>.from(response.data.map((x) => WeatherResponseModel.fromJson(x))),
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      } else {
        return BaseResponseModel<List<WeatherResponseModel>>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      debugPrint("DioException in WeatherApiService getAll: ${e.response?.data}");
      
      // Backend'den gelen hata kodunu işle
      String? errorCode = e.response?.data?['code'];
      String errorMessage = errorCode != null 
          ? ExceptionHandler.handleException(errorCode)
          : "Hava durumu verileri alınamadı";
      
      return BaseResponseModel<List<WeatherResponseModel>>(
        data: null,
        message: errorMessage,
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }
}
