import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // Import kDebugMode
import 'package:rencber_mobile/core/cache/secure_storage.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/services/_dio_manager/services_path.dart';
import 'package:kartal/kartal.dart';

class DioManager {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: ServicesPath.instance.baseUrl,
      contentType: "application/json",
    ),
  )..interceptors.add(
      // Add interceptor here
      kDebugMode
          ? LogInterceptor(responseBody: true, requestBody: true, responseHeader: true, requestHeader: true, logPrint: (obj) => debugPrint('[Dio] ${obj.toString().length > 300 ? '${obj.toString().substring(0, 300)}...' : obj}'))
          : LogInterceptor(responseBody: false, requestBody: false, responseHeader: false, requestHeader: false),
    );

  static BaseResponseModel<T> dioError<T>(DioException e) {
    if (e.error is SocketException) {
      return BaseResponseModel<T>(
        data: null,
        message: 'No internet connection',
        statusCode: 0,
      );
    }
    if (e.response?.data is Map<String, dynamic>) {
      return BaseResponseModel<T>(
        data: null,
        message: (e.response?.data as Map<String, dynamic>)['message'],
        statusCode: e.response?.statusCode,
        errorCode: (e.response?.data as Map<String, dynamic>)['errorCode'],
      );
    } else {
      return BaseResponseModel<T>(
        data: null,
        message: "",
        statusCode: 404,
        errorCode: "",
      );
      //throw Exception('Invalid data format');
    }
  }

  static Future<Options> getOptions() async {
    var userToken = await SecureStorage.instance.readSecureData("accessToken");
    // bool hasExpired = JwtDecoder.isExpired(userToken ?? "");
    // if (hasExpired) {
    //   var refreshToken = await SecureStorage.instance.readSecureData("refreshToken");
    //   RefreshTokenApiService.instance.post(refreshToken ?? "").then((value) {
    //     if (value.statusCode == 200 && value.data != null) {
    //       SecureStorage.instance.writeSecureData("accessToken", value.data?.accessToken ?? "");
    //       SecureStorage.instance.writeSecureData("refreshToken", value.data?.refreshToken ?? "");
    //     }
    //   });
    // }
    debugPrint('userToken: $userToken');
    if (userToken.ext.isNotNullOrNoEmpty) {
      return Options(
        headers: {
          "authorization": "Bearer $userToken",
        },
      );
    } else {
      return Options(
        headers: {},
        validateStatus: (status) {
          return status! < 500;
        },
      );
    }
  }
}
