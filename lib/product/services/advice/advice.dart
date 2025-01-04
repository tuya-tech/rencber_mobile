import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rencber_mobile/product/models/advice/advice_response.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_mixin.dart';
import 'package:rencber_mobile/product/services/_dio_manager/services_path.dart';

class AdviceApiService {
  AdviceApiService._();
  static final instance = AdviceApiService._();

  Future<BaseResponseModel<List<AdviceResponseModel>>> get() async {
    try {
      final response = await DioManager.dio.get(
        ServicesPath.instance.advice,
        options: await DioManager.getOptions(),
      );

      if (response.statusCode != 200) {
        return BaseResponseModel<List<AdviceResponseModel>>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }

      return BaseResponseModel<List<AdviceResponseModel>>(
        data: (response.data as List).map((e) => AdviceResponseModel.fromJson(e)).toList(),
        message: response.statusMessage,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      debugPrint('AdviceApiService get: ${e.message}');
      return DioManager.dioError<List<AdviceResponseModel>>(e);
    }
  }

  Future<BaseResponseModel<AdviceResponseModel>> getById(int id) async {
    try {
      final response = await DioManager.dio.get(
        "${ServicesPath.instance.advice}/$id",
        options: await DioManager.getOptions(),
      );

      if (response.statusCode != 200) {
        return BaseResponseModel<AdviceResponseModel>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }

      return BaseResponseModel<AdviceResponseModel>(
        data: AdviceResponseModel.fromJson(response.data),
        message: response.statusMessage,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      debugPrint('AdviceApiService get: ${e.message}');
      return DioManager.dioError<AdviceResponseModel>(e);
    }
  }
}
