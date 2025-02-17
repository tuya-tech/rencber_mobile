import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/product/services/field/field.dart';
import 'package:rencber_mobile/product/services/field/field_islem_service.dart';

// final fieldIdFutureProvider = FutureProvider.autoDispose.family<BaseResponseModel<FieldResponseModel>, int>(
//   (ref, id) async {
//     return FieldApiService.instance.getById(id);
//   },
// );

final fieldIdFutureProvider = FutureProvider.family.autoDispose<dynamic, int>(
  (ref, id) async {
    final field = FieldApiService.instance;
    final fieldIslem = FieldIslemApiService.instance;
    return {
      'fieldById': await field.getById(id).then((value) => value.data),
      'fieldIslem': await fieldIslem.get(id).then((value) => value.data),
    };
  },
);
