import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/core/cache/secure_storage.dart';
import 'package:rencber_mobile/product/models/field/field_response.dart';
import 'package:rencber_mobile/product/services/advice/advice.dart';
import 'package:rencber_mobile/product/services/field/field.dart';
import 'package:rencber_mobile/product/services/weather/weather.dart';

final homeFutureProvider = FutureProvider(
  (ref) async {
    final weather = WeatherApiService.instance;
    final advice = AdviceApiService.instance;
    final field = FieldApiService.instance;
    return {
      'advice': await advice.get().then((value) => value.data?.where((element) => element.brand != 'Aydınlı').toList()),
      'field': await field.get().then((value) async {
        var outlineField = value.data?.where((element) => element.outline == true).toList();
        var outLineFieldNotList = outlineField?.first;
        debugPrint("outLineFieldNotList: ${outLineFieldNotList?.toJson()}");
        await SecureStorage.instance.writeFieldModel("outLineField", outLineFieldNotList ?? FieldResponseModel());
        return value.data;
      }),
      'weather': await weather.get().then((value) => value.data), //TODO IDyı düzenle
    };
  },
);
