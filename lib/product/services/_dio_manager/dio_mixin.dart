import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/services/_dio_manager/services_path.dart';

class DioManager {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: ServicesPath.instance.baseUrl,
      contentType: "application/json",
    ),
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
      throw Exception('Invalid data format');
    }
  }

  static Future<Options> getOptions() async {
    // var userToken = await SecureStorage.instance.readSecureData("accessToken");
    // if (userToken.ext.isNotNullOrNoEmpty) {
    //   return Options(
    //     headers: {
    //       "authorization": "Bearer $userToken",
    //       "crncy": currency,
    //       "apptype": "mobile",
    //       "Accept-Language": language,
    //     },
    //   );
    // }
    return Options(
      headers: {},
    );
  }
}
