import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/models/field/field_response.dart';
import 'package:rencber_mobile/product/services/field/field.dart';

final fieldIdFutureProvider = FutureProvider.autoDispose.family<BaseResponseModel<FieldResponseModel>, int>(
  (ref, id) async {
    return FieldApiService.instance.getById(id);
  },
);
