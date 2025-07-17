import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rencber_mobile/core/controller/exception.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/models/login/login_response.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_mixin.dart';
import 'package:rencber_mobile/product/services/_dio_manager/services_path.dart';

class LoginApiService {
  LoginApiService._();
  static final instance = LoginApiService._();

  Future<BaseResponseModel<bool>> loginRequest(String phoneNumber) async {
    try {
      final response = await DioManager.dio.post(
        ServicesPath.instance.loginRequest,
        data: {"phone": phoneNumber},
        //options: await DioManager.getOptions(),
      );

      return BaseResponseModel<bool>(
        data: response.data != null,
        message: response.statusMessage,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      debugPrint('LoginApiService loginRequest: ${e.response?.data}');
      
      // Backend'den gelen hata kodunu işle
      String? errorCode = e.response?.data?['code'];
      String errorMessage;
      
      if (errorCode != null) {
        errorMessage = ExceptionHandler.handleException(errorCode);
        // CODE-1003 için özel mesaj ekle
        if (errorCode == "CODE-1003") {
          errorMessage = "Kod geçerli, doğrulama ekranına yönlendiriliyorsunuz";
        }
      } else {
        errorMessage = "Giriş isteği gönderilemedi";
      }
      
      return BaseResponseModel<bool>(
        data: false,
        message: errorCode != null ? "[$errorCode] $errorMessage" : errorMessage,
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }

  Future<BaseResponseModel<LoginResponseModel>> login(String phoneNumber, String phoneCode, String fbToken) async {
    try {
      final response = await DioManager.dio.post(
        ServicesPath.instance.login,
        data: {"phone": phoneNumber, "code": phoneCode, "fbToken": fbToken},
        //options: await DioManager.getOptions(),
      );

      if (response.statusCode != 200) {
        return BaseResponseModel<LoginResponseModel>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }

      return BaseResponseModel<LoginResponseModel>(
        data: LoginResponseModel.fromJson(response.data),
        message: response.statusMessage,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      debugPrint('LoginApiService login: ${e.response?.data}');
      
      // Backend'den gelen hata kodunu işle
      String? errorCode = e.response?.data?['code'];
      String errorMessage;
      
      if (errorCode != null) {
        errorMessage = ExceptionHandler.handleException(errorCode);
        // CODE-1003 için özel mesaj ekle
        if (errorCode == "CODE-1003") {
          errorMessage = "Kod geçerli ancak giriş tamamlanamadı, lütfen tekrar deneyiniz";
        }
      } else {
        errorMessage = "Giriş yapılamadı";
      }
      
      return BaseResponseModel<LoginResponseModel>(
        data: null,
        message: errorCode != null ? "[$errorCode] $errorMessage" : errorMessage,
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }
}
