import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/cache/secure_storage.dart';
import 'package:rencber_mobile/product/models/field/field_response.dart';
import 'package:rencber_mobile/product/services/advice/advice.dart';
import 'package:rencber_mobile/product/services/field/field.dart';
import 'package:rencber_mobile/product/services/field/field_islem_service.dart';
import 'package:rencber_mobile/product/services/weather/weather.dart';

final homeFutureProvider = FutureProvider(
  (ref) async {
    try {
      final weather = WeatherApiService.instance;
      final advice = AdviceApiService.instance;
      final field = FieldApiService.instance;
      final fieldIslem = FieldIslemApiService.instance;
      
      return {
        'advice': await advice.get().then((value) {
          if (value.statusCode == 200) {
            return value.data?.where((element) => element.brand != 'Aydınlı').toList();
          } else {
            debugPrint("Advice API Error: ${value.message}");
            return <dynamic>[];
          }
        }),
        'field': await field.get().then((value) async {
          if (value.statusCode == 200) {
            var outlineField = value.data?.where((element) => element.outline == true).toList();
            var outLineFieldNotList = outlineField?.firstOrNull;
            await SecureStorage.instance.writeFieldModel("outLineField", outLineFieldNotList ?? FieldResponseModel());
            debugPrint("value.data: ${value.data}");
            if (value.data.ext.isNotNullOrEmpty) {
              return value.data;
            } else {
              return null;
            }
          } else {
            debugPrint("Field API Error: ${value.message}");
            return null;
          }
        }),
        'fieldIslem': await fieldIslem.get(null).then((value) {
          if (value.statusCode == 200) {
            return value.data;
          } else {
            debugPrint("FieldIslem API Error: ${value.message}");
            return <dynamic>[];
          }
        }),
        'weather': await weather.get().then((value) {
          if (value.statusCode == 200) {
            return value.data;
          } else {
            debugPrint("Weather API Error: ${value.message}");
            return null;
          }
        }),
        'errors': <String>[], // Hata mesajlarını toplamak için
      };
    } catch (e) {
      debugPrint("HomeFutureProvider Error: $e");
      rethrow;
    }
  },
);
