import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rencber_mobile/core/controller/exception.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_mixin.dart';
import 'package:rencber_mobile/product/services/_dio_manager/services_path.dart';

class ValideCodeApiService {
  ValideCodeApiService._();
  static final instance = ValideCodeApiService._();

  Future<BaseResponseModel<bool>> post(String code, String phoneNumber) async {
    try {
      final response = await DioManager.dio.put(
        ServicesPath.instance.valideCode,
        data: {"code": code, "phone": phoneNumber},
        //options: await DioManager.getOptions(),
      );

      return BaseResponseModel<bool>(
        data: response.data,
        message: response.statusMessage,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      debugPrint("ValideCodeApiService -> post Error: ${e.response?.data}");
      
      // Backend'den gelen hata kodunu işle
      String? errorCode = e.response?.data?['code'];
      String errorMessage;
      
      if (errorCode != null) {
        errorMessage = ExceptionHandler.handleException(errorCode);
        // CODE-1003 için özel mesaj ekle
        if (errorCode == "CODE-1003") {
          errorMessage = "Kod geçerli ancak tekrar denemeniz gerekiyor";
        }
      } else {
        errorMessage = "Kod doğrulanamadı";
      }
      
      return BaseResponseModel<bool>(
        data: false,
        message: errorCode != null ? "[$errorCode] $errorMessage" : errorMessage,
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }
}
