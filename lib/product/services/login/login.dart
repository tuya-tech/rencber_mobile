import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
      debugPrint('LoginApiService post: ${e.message}');
      return DioManager.dioError<bool>(e);
    }
  }

  Future<BaseResponseModel<LoginResponseModel>> login(String phoneNumber, String phoneCode) async {
    try {
      final response = await DioManager.dio.post(
        ServicesPath.instance.login,
        data: {"phone": phoneNumber, "code": phoneCode},
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
      debugPrint('LoginApiService post: ${e.message}');
      return DioManager.dioError<LoginResponseModel>(e);
    }
  }
}
