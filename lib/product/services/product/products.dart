import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/models/error_response.dart';
import 'package:rencber_mobile/product/models/product/product_response.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_mixin.dart';
import 'package:rencber_mobile/product/services/_dio_manager/services_path.dart';

class ProductApiService {
  ProductApiService._();
  static final instance = ProductApiService._();

  Future<BaseResponseModel<List<ProductResponseModel>>> get() async {
    try {
      final response = await DioManager.dio.get(
        ServicesPath.instance.products,
        options: await DioManager.getOptions(),
      );

      if (response.statusCode != 200) {
        return BaseResponseModel<List<ProductResponseModel>>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }

      return BaseResponseModel<List<ProductResponseModel>>(
        data: (response.data as List).map((e) => ProductResponseModel.fromJson(e)).toList(),
        message: response.statusMessage,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      debugPrint('AdviceApiService get: ${e.message}');
      return DioManager.dioError<List<ProductResponseModel>>(e);
    }
  }

  Future<BaseResponseModel<ProductResponseModel>> getById(int id) async {
    try {
      final response = await DioManager.dio.get(
        "${ServicesPath.instance.products}/$id",
        options: await DioManager.getOptions(),
      );

      if (response.statusCode != 200) {
        return BaseResponseModel<ProductResponseModel>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }

      return BaseResponseModel<ProductResponseModel>(
        data: ProductResponseModel.fromJson(response.data),
        message: response.statusMessage,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      debugPrint('AdviceApiService get: ${e.message}');
      return DioManager.dioError<ProductResponseModel>(e);
    }
  }

  Future<BaseResponseModel<bool>> post(ProductResponseModel data) async {
    try {
      final response = await DioManager.dio.post(
        ServicesPath.instance.products,
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

  Future<BaseResponseModel<dynamic>> put(ProductResponseModel data) async {
    try {
      final response = await DioManager.dio.put(
        ServicesPath.instance.products,
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
