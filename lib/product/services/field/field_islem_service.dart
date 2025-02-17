import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rencber_mobile/core/cache/secure_storage.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/models/field/field_islem_response.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_mixin.dart';
import 'package:rencber_mobile/product/services/_dio_manager/services_path.dart';

class FieldIslemApiService {
  FieldIslemApiService._();
  static final instance = FieldIslemApiService._();

  Future<BaseResponseModel<List<FieldIslemResponseModel>>> get(int? fieldById) async {
    try {
      debugPrint('FieldIslemApiService get: $fieldById');
      var fieldData = await SecureStorage.instance.readFieldModel('outLineField');
      var fieldId = fieldData?.id ?? 0;
      final response = await DioManager.dio.get(
        '${ServicesPath.instance.fieldIslem}/${fieldById ?? fieldId}',
        options: await DioManager.getOptions(),
      );

      if (response.statusCode != 200) {
        return BaseResponseModel<List<FieldIslemResponseModel>>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }

      return BaseResponseModel<List<FieldIslemResponseModel>>(
        data: (response.data as List).map((e) => FieldIslemResponseModel.fromJson(e)).toList(),
        message: response.statusMessage,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      debugPrint('FieldIslemApiService get: ${e.message}');
      return DioManager.dioError<List<FieldIslemResponseModel>>(e);
    }
  }

  Future<BaseResponseModel<FieldIslemResponseModel>> post(String islemTipi, bool yapildi, int? fieldById, String date) async {
    try {
      var fieldData = await SecureStorage.instance.readFieldModel('outLineField');
      var fieldId = fieldData?.id ?? 0;
      debugPrint('FieldIslemApiService post: $islemTipi, $yapildi, ${fieldById ?? fieldId}, $date');
      final response = await DioManager.dio.post(
        ServicesPath.instance.fieldIslemManuel,
        data: {
          'islemTipi': islemTipi,
          'yapildi': yapildi,
          'fieldId': fieldById ?? fieldId,
          'date': date,
        },
        options: await DioManager.getOptions(),
      );

      if (response.statusCode != 200) {
        return BaseResponseModel<FieldIslemResponseModel>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }

      return BaseResponseModel<FieldIslemResponseModel>(
        data: FieldIslemResponseModel.fromJson(response.data),
        message: response.statusMessage,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      debugPrint('FieldIslemApiService get: ${e.message}');
      return DioManager.dioError<FieldIslemResponseModel>(e);
    }
  }
}
