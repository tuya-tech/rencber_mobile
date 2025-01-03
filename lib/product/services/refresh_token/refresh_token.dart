import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/models/login/login_response.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_mixin.dart';
import 'package:rencber_mobile/product/services/_dio_manager/services_path.dart';

class RefreshTokenApiService {
  RefreshTokenApiService._();
  static final instance = RefreshTokenApiService._();

  Future<BaseResponseModel<LoginResponseModel>> post(String refreshToken) async {
    debugPrint("refreshToken: $refreshToken");
    try {
      final response = await DioManager.dio.post(
        ServicesPath.instance.refreshToken,
        data: {
          "refreshToken": refreshToken,
        },
        //options: await DioManager.getOptions(),
      );

      if (response.statusCode == 200) {
        return BaseResponseModel<LoginResponseModel>(
          data: LoginResponseModel.fromJson(response.data),
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      } else {
        return BaseResponseModel<LoginResponseModel>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      debugPrint("RefreshTokenApiService: $e");
      return DioManager.dioError<LoginResponseModel>(e);
    }
  }
}
