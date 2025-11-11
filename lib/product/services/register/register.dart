import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rencber_mobile/core/controller/exception.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/models/register/register_request.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_mixin.dart';
import 'package:rencber_mobile/product/services/_dio_manager/services_path.dart';

class RegisterApiService {
  RegisterApiService._();
  static final instance = RegisterApiService._();

  Future<BaseResponseModel<bool>> post(RegisterRequestModel userData) async {
    try {
      final response = await DioManager.dio.post(
        ServicesPath.instance.register,
        data: userData,
        //options: await DioManager.getOptions(),
      );

      debugPrint("RegisterApiService: ${response.data}");
      debugPrint("RegisterApiService Error: ${response.data}");
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return BaseResponseModel<bool>(
          data: true,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      } else {
        return BaseResponseModel<bool>(
          data: false,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      debugPrint('RegisterApiService post: ${e.response?.data}');
      
      // Backend'den gelen hata kodunu işle
      String? errorCode = e.response?.data?['code'];
      String errorMessage = errorCode != null 
          ? ExceptionHandler.handleException(errorCode)
          : "Kayıt işlemi başarısız";
      
      return BaseResponseModel<bool>(
        data: false,
        message: errorMessage,
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }
}
