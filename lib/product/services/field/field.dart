import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/models/error_response.dart';
import 'package:rencber_mobile/product/models/field/field_request.dart';
import 'package:rencber_mobile/product/models/field/field_response.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_mixin.dart';
import 'package:rencber_mobile/product/services/_dio_manager/services_path.dart';

class FieldApiService {
  FieldApiService._();
  static final instance = FieldApiService._();

  Future<BaseResponseModel<List<FieldResponseModel>>> get() async {
    try {
      final response = await DioManager.dio.get(
        ServicesPath.instance.field,
        options: await DioManager.getOptions(),
      );

      if (response.statusCode != 200) {
        return BaseResponseModel<List<FieldResponseModel>>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }

      return BaseResponseModel<List<FieldResponseModel>>(
        data: (response.data as List).map((e) => FieldResponseModel.fromJson(e)).toList(),
        message: response.statusMessage,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      debugPrint('FieldApiService get: ${e.message}');
      return DioManager.dioError<List<FieldResponseModel>>(e);
    }
  }

  Future<BaseResponseModel<FieldResponseModel>> getById(int id) async {
    try {
      final response = await DioManager.dio.get(
        "${ServicesPath.instance.field}/$id",
        options: await DioManager.getOptions(),
      );

      if (response.statusCode != 200) {
        return BaseResponseModel<FieldResponseModel>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }

      return BaseResponseModel<FieldResponseModel>(
        data: FieldResponseModel.fromJson(response.data),
        message: response.statusMessage,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      debugPrint('AdviceApiService get: ${e.message}');
      return DioManager.dioError<FieldResponseModel>(e);
    }
  }

  Future<BaseResponseModel<bool>> post(FieldRequestModel data) async {
    try {
      final response = await DioManager.dio.post(
        ServicesPath.instance.field,
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

  Future<BaseResponseModel<dynamic>> put(FieldRequestModel data) async {
    try {
      final response = await DioManager.dio.put(
        ServicesPath.instance.field,
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
