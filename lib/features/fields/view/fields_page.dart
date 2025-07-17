import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/features/fields/view/fields.dart';
import 'package:rencber_mobile/product/models/field/field_response.dart';
import 'package:rencber_mobile/product/provider/field/field.dart';

class FieldsPage extends ConsumerWidget {
  const FieldsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldsAsync = ref.watch(fieldsProvider);

    return fieldsAsync.when(
      data: (fieldData) {
        if (fieldData.isEmpty) {
          return const Scaffold(
            backgroundColor: ColorManager.bgColor,
            body: Center(
              child: Text("Henüz tarla eklenmemiş"),
            ),
          );
        }
        return FieldList(fieldData: fieldData.cast<FieldResponseModel>());
      },
      loading: () => const Scaffold(
        backgroundColor: ColorManager.bgColor,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => Scaffold(
        backgroundColor: ColorManager.bgColor,
        body: Center(
          child: Text("Bir hata oluştu: $error"),
        ),
      ),
    );
  }
}
