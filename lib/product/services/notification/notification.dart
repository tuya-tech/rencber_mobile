import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rencber_mobile/core/controller/exception.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/models/notification/notification_request.dart';
import 'package:rencber_mobile/product/models/notification/notification_response.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_mixin.dart';
import 'package:rencber_mobile/product/services/_dio_manager/services_path.dart';

class NotificationApiService {
  NotificationApiService._();
  static final instance = NotificationApiService._();

  Future<BaseResponseModel<List<NotificationRequestModel>>> getNotificationSettingsList() async {
    try {
      final response = await DioManager.dio.get(
        ServicesPath.instance.notificationSettings,
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
      debugPrint('NotificationApiService get: ${e.response?.data}');
      
      // Backend'den gelen hata kodunu işle
      String? errorCode = e.response?.data?['code'];
      String errorMessage = errorCode != null 
          ? ExceptionHandler.handleException(errorCode)
          : "Bildirim ayarları alınamadı";
      
      return BaseResponseModel<List<NotificationRequestModel>>(
        data: null,
        message: errorMessage,
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }

  Future<BaseResponseModel<NotificationRequestModel>> getById(int id) async {
    try {
      final response = await DioManager.dio.get(
        "${ServicesPath.instance.notificationSettings}/$id",
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
      debugPrint('NotificationApiService getById: ${e.response?.data}');
      
      // Backend'den gelen hata kodunu işle
      String? errorCode = e.response?.data?['code'];
      String errorMessage = errorCode != null 
          ? ExceptionHandler.handleException(errorCode)
          : "Bildirim ayarı alınamadı";
      
      return BaseResponseModel<NotificationRequestModel>(
        data: null,
        message: errorMessage,
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }

  Future<BaseResponseModel<bool>> post(NotificationRequestModel data) async {
    try {
      final response = await DioManager.dio.post(
        ServicesPath.instance.notificationSettings,
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
      debugPrint('NotificationApiService post: ${e.response?.data}');
      
      // Backend'den gelen hata kodunu işle
      String? errorCode = e.response?.data?['code'];
      String errorMessage = errorCode != null 
          ? ExceptionHandler.handleException(errorCode)
          : "Bildirim ayarı eklenemedi";
      
      return BaseResponseModel<bool>(
        data: false,
        message: errorMessage,
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }

  Future<BaseResponseModel<dynamic>> put(NotificationRequestModel data) async {
    try {
      final response = await DioManager.dio.put(
        ServicesPath.instance.notificationSettings,
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
      debugPrint('NotificationApiService put: ${e.response?.data}');
      
      // Backend'den gelen hata kodunu işle
      String? errorCode = e.response?.data?['code'];
      String errorMessage = errorCode != null 
          ? ExceptionHandler.handleException(errorCode)
          : "Bildirim ayarı güncellenemedi";
      
      return BaseResponseModel<bool>(
        data: false,
        message: errorMessage,
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }

  Future<BaseResponseModel<List<NotificationResponseModel>>> getNotificationList() async {
    try {
      final response = await DioManager.dio.get(
        ServicesPath.instance.notificationBildirim,
        options: await DioManager.getOptions(),
      );

      if (response.statusCode != 200) {
        return BaseResponseModel<List<NotificationResponseModel>>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }

      return BaseResponseModel<List<NotificationResponseModel>>(
        data: (response.data as List).map((e) => NotificationResponseModel.fromJson(e)).toList(),
        message: response.statusMessage,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      debugPrint('NotificationApiService getNotificationList: ${e.response?.data}');
      
      // Backend'den gelen hata kodunu işle
      String? errorCode = e.response?.data?['code'];
      String errorMessage = errorCode != null 
          ? ExceptionHandler.handleException(errorCode)
          : "Bildirimler alınamadı";
      
      return BaseResponseModel<List<NotificationResponseModel>>(
        data: null,
        message: errorMessage,
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }

  Future<BaseResponseModel<NotificationResponseModel>> updateNotification({
  required int id,
  bool? read,
  bool? processed,
  String? userResponse,
}) async {
  try {
    final body = {
      if (read != null) 'read': read,
      if (processed != null) 'processed': processed,
      if (userResponse != null) 'response': userResponse,
    };

    final response = await DioManager.dio.put(
      "${ServicesPath.instance.notificationBildirim}/$id",
      data: body,
      options: await DioManager.getOptions(),
    );

    return BaseResponseModel<NotificationResponseModel>(
      data: NotificationResponseModel.fromJson(response.data),
      message: response.statusMessage,
      statusCode: response.statusCode,
    );
  } on DioException catch (e) {
    debugPrint('NotificationApiService updateNotification: ${e.response?.data}');

    String? errorCode = e.response?.data?['code'];
    String errorMessage = errorCode != null
        ? ExceptionHandler.handleException(errorCode)
        : "Bildirim güncellenemedi";

    return BaseResponseModel<NotificationResponseModel>(
      data: null,
      message: errorMessage,
      statusCode: e.response?.statusCode ?? 500,
    );
  }
}

}
