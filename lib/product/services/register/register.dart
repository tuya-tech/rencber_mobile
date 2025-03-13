import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
      debugPrint('RegisterApiService get: ${e.message}');
      return DioManager.dioError<bool>(e);
    }
  }

  //   Future<BaseResponseModel<List<NotificationResponseModel>>> getNotification() async {
  //   try {
  //     final response = await DioManager.dio.get(
  //       ServicesPath.instance.notificationBildirim,
  //       options: await DioManager.getOptions(),
  //     );

  //     if (response.statusCode != 200) {
  //       return BaseResponseModel<List<NotificationResponseModel>>(
  //         data: null,
  //         message: response.statusMessage,
  //         statusCode: response.statusCode,
  //       );
  //     }

  //     return BaseResponseModel<List<NotificationResponseModel>>(
  //       data: (response.data as List).map((e) => NotificationResponseModel.fromJson(e)).toList(),
  //       message: response.statusMessage,
  //       statusCode: response.statusCode,
  //     );
  //   } on DioException catch (e) {
  //     debugPrint('AdviceApiService get: ${e.message}');
  //     return DioManager.dioError<List<NotificationResponseModel>>(e);
  //   }
  // }
}
