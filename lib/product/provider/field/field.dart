import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/product/services/field/field.dart';
import 'package:rencber_mobile/product/services/field/field_islem_service.dart';

// Fields list provider - tüm fieldları getiren provider
final fieldsProvider = FutureProvider.autoDispose(
  (ref) async {
    try {
      final fieldService = FieldApiService.instance;
      final response = await fieldService.get();
      
      if (response.statusCode == 200) {
        return response.data ?? [];
      } else {
        debugPrint("FieldsProvider Error: ${response.message}");
        return [];
      }
    } catch (e) {
      debugPrint("FieldsProvider Exception: $e");
      rethrow;
    }
  },
);

// final fieldIdFutureProvider = FutureProvider.autoDispose.family<BaseResponseModel<FieldResponseModel>, int>(
//   (ref, id) async {
//     return FieldApiService.instance.getById(id);
//   },
// );

final fieldIdFutureProvider = FutureProvider.family.autoDispose<dynamic, int>(
  (ref, id) async {
    try {
      final field = FieldApiService.instance;
      final fieldIslem = FieldIslemApiService.instance;
      
      final fieldResponse = await field.getById(id);
      final fieldIslemResponse = await fieldIslem.get(id);
      
      return {
        'fieldById': fieldResponse.statusCode == 200 ? fieldResponse.data : null,
        'fieldIslem': fieldIslemResponse.statusCode == 200 ? fieldIslemResponse.data : [],
        'errors': {
          'field': fieldResponse.statusCode != 200 ? fieldResponse.message : null,
          'fieldIslem': fieldIslemResponse.statusCode != 200 ? fieldIslemResponse.message : null,
        }
      };
    } catch (e) {
      debugPrint("FieldIdFutureProvider Error: $e");
      rethrow;
    }
  },
);
