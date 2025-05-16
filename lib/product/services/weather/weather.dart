import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rencber_mobile/core/cache/secure_storage.dart';
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
      debugPrint("fieldId: $fieldId");
      final response = await DioManager.dio.get(
        "${ServicesPath.instance.weather}/field/$fieldId",
        options: await DioManager.getOptions(),
      );

      debugPrint("WeatherApiService get: ${ServicesPath.instance.weather}/field/$fieldId");

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
      return DioManager.dioError<List<WeatherResponseModel>>(e);
    }
  }
}
