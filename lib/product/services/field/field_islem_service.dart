import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rencber_mobile/core/cache/secure_storage.dart';
import 'package:rencber_mobile/core/controller/exception.dart';
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
      debugPrint('FieldIslemApiService get: ${e.response?.data}');
      
      // Backend'den gelen hata kodunu işle
      String? errorCode = e.response?.data?['code'];
      String errorMessage = errorCode != null 
          ? ExceptionHandler.handleException(errorCode)
          : "Tarla işlem verileri alınamadı";
      
      return BaseResponseModel<List<FieldIslemResponseModel>>(
        data: null,
        message: errorMessage,
        statusCode: e.response?.statusCode ?? 500,
      );
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
      debugPrint('FieldIslemApiService post: ${e.response?.data}');
      
      // Backend'den gelen hata kodunu işle
      String? errorCode = e.response?.data?['code'];
      String errorMessage = errorCode != null 
          ? ExceptionHandler.handleException(errorCode)
          : "Tarla işlemi eklenemedi";
      
      return BaseResponseModel<FieldIslemResponseModel>(
        data: null,
        message: errorMessage,
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }

  /// Yeni: PUT işlemleri (dropdown seçimine göre)
  Future<BaseResponseModel<void>> updateFieldIslemBySelection({
    required int fieldId,
    required String islemTipi,
    bool value = true,
  }) async {
    try {
      String endpoint = '';
      Map<String, dynamic> queryParams = {};

      switch (islemTipi) {
        case 'OTLANMA':
          endpoint = '${ServicesPath.instance.fieldIslemOtlanma}$fieldId';
          queryParams = {'otlanma': value};
          break;
        case 'BUYUME_GELISME':
        case 'BUYUME':
          endpoint = '${ServicesPath.instance.fieldIslemBuyume}$fieldId';
          queryParams = {'buyumeDurumu': value};
          break;
        case 'HASTALIK':
          endpoint = '${ServicesPath.instance.fieldIslemHastalik}$fieldId';
          queryParams = {'hastalikDurumu': value};
          break;
        default:
          return BaseResponseModel<void>(
            data: null,
            message:
                "Seçilen işlem tipi için uygun API endpoint bulunamadı: $islemTipi",
            statusCode: 400,
          );
      }

      debugPrint('PUT isteği gönderiliyor: $endpoint, params: $queryParams');

      final response = await DioManager.dio.put(
        endpoint,
        queryParameters: queryParams,
        options: await DioManager.getOptions(),
      );

      if (response.statusCode != 200) {
        return BaseResponseModel<void>(
          data: null,
          message: response.statusMessage ?? 'İşlem başarısız',
          statusCode: response.statusCode,
        );
      }

      return BaseResponseModel<void>(
        data: null,
        message: "İşlem başarıyla güncellendi",
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      debugPrint('FieldIslemApiService PUT error: ${e.response?.data}');
      String? errorCode = e.response?.data?['code'];
      String errorMessage = errorCode != null
          ? ExceptionHandler.handleException(errorCode)
          : "Tarla işlemi güncellenemedi";
      return BaseResponseModel<void>(
        data: null,
        message: errorMessage,
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }
}
