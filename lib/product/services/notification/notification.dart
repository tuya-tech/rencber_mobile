import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/models/error_response.dart';
import 'package:rencber_mobile/product/models/notification/notification_request.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_mixin.dart';
import 'package:rencber_mobile/product/services/_dio_manager/services_path.dart';

class NotificationApiService {
  NotificationApiService._();
  static final instance = NotificationApiService._();

  Future<BaseResponseModel<List<NotificationRequestModel>>> get() async {
    try {
      final response = await DioManager.dio.get(
        ServicesPath.instance.notification,
        options: await DioManager.getOptions(),
      );

      if (response.statusCode != 200) {
        return BaseResponseModel<List<NotificationRequestModel>>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }

      return BaseResponseModel<List<NotificationRequestModel>>(
        data: (response.data as List).map((e) => NotificationRequestModel.fromJson(e)).toList(),
        message: response.statusMessage,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      debugPrint('AdviceApiService get: ${e.message}');
      return DioManager.dioError<List<NotificationRequestModel>>(e);
    }
  }

  Future<BaseResponseModel<NotificationRequestModel>> getById(int id) async {
    try {
      final response = await DioManager.dio.get(
        "${ServicesPath.instance.notification}/$id",
        options: await DioManager.getOptions(),
      );

      if (response.statusCode != 200) {
        return BaseResponseModel<NotificationRequestModel>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }

      return BaseResponseModel<NotificationRequestModel>(
        data: NotificationRequestModel.fromJson(response.data),
        message: response.statusMessage,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      debugPrint('AdviceApiService get: ${e.message}');
      return DioManager.dioError<NotificationRequestModel>(e);
    }
  }

  Future<BaseResponseModel<bool>> post(NotificationRequestModel data) async {
    try {
      final response = await DioManager.dio.post(
        ServicesPath.instance.notification,
        data: data,
        options: await DioManager.getOptions(),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        return BaseResponseModel<bool>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }

      return BaseResponseModel<bool>(
        data: true,
        message: response.statusMessage,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      debugPrint('AdviceApiService get: ${e.message}');
      return DioManager.dioError<bool>(e);
    }
  }

  Future<BaseResponseModel<dynamic>> put(NotificationRequestModel data) async {
    try {
      final response = await DioManager.dio.put(
        ServicesPath.instance.notification,
        data: data,
        options: await DioManager.getOptions(),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        return BaseResponseModel<bool>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }

      return BaseResponseModel<bool>(
        data: true,
        message: response.statusMessage,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      return BaseResponseModel<ErrorResponseModel>(
        data: ErrorResponseModel.fromJson(e.response!.data),
        message: e.response!.statusMessage,
        statusCode: e.response!.statusCode,
      );
    }
  }
}
