import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/models/news/news_response.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_mixin.dart';
import 'package:rencber_mobile/product/services/_dio_manager/services_path.dart';

class NewsApiService {
  NewsApiService._();
  static final instance = NewsApiService._();

  Future<BaseResponseModel<List<NewsResponseModel>>> get() async {
    try {
      final response = await DioManager.dio.get(
        ServicesPath.instance.news,
        options: await DioManager.getOptions(),
      );

      if (response.statusCode != 200) {
        return BaseResponseModel<List<NewsResponseModel>>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }

      return BaseResponseModel<List<NewsResponseModel>>(
        data: (response.data as List).map((e) => NewsResponseModel.fromJson(e)).toList(),
        message: response.statusMessage,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      debugPrint('NewsApiService get: ${e.message}');
      return DioManager.dioError<List<NewsResponseModel>>(e);
    }
  }
}
