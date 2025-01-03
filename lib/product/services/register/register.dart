import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/models/error_response.dart';
import 'package:rencber_mobile/product/models/register/register_request.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_mixin.dart';
import 'package:rencber_mobile/product/services/_dio_manager/services_path.dart';

class RegisterApiService {
  RegisterApiService._();
  static final instance = RegisterApiService._();

  Future<BaseResponseModel<dynamic>> post(RegisterRequestModel userData) async {
    try {
      final response = await DioManager.dio.post(
        ServicesPath.instance.register,
        data: userData,
        //options: await DioManager.getOptions(),
      );

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
      return BaseResponseModel<ErrorResponseModel>(
        data: ErrorResponseModel.fromJson(e.response!.data),
        message: e.response!.statusMessage,
        statusCode: e.response!.statusCode,
      );
    }
  }
}
