// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/constant/constant.dart';
import 'package:rencber_mobile/core/widget/loading/loading.dart';
import 'package:rencber_mobile/core/widget/toastr/toastr.dart';
import 'package:rencber_mobile/features/fields/view/add_field.dart';
import 'package:rencber_mobile/product/models/field/field_request.dart';
import 'package:rencber_mobile/product/provider/field/field.dart';
import 'package:rencber_mobile/product/provider/home/home_provider.dart';
import 'package:rencber_mobile/product/services/field/field.dart';

mixin FieldAddMixin on ConsumerState<FieldAddView> {
  late final TextEditingController fieldNameController;
  late final TextEditingController productController;
  late final TextEditingController productIdController;
  late final TextEditingController dateTimeController;
  late final TextEditingController gubreController;
  late final TextEditingController cityDistrictController;
  late final TextEditingController cityController;
  late final TextEditingController districtController;
  bool sulamaGubre = false;
  bool outline = true;

  int selectedCityId = 0;
  int selectedDistrictId = 0;

  @override
  void initState() {
    super.initState();
    fieldNameController = TextEditingController();
    productController = TextEditingController();
    productIdController = TextEditingController();
    dateTimeController = TextEditingController();
    gubreController = TextEditingController();
    cityDistrictController = TextEditingController();
    cityController = TextEditingController();
    districtController = TextEditingController();
  }

  void setSulamaGubre(String value) {
    switch (value) {
      case "Evet":
        sulamaGubre = true;
        break;
      case "Hayır":
        sulamaGubre = false;
        break;
    }
  }

  void onSaved() async {
    debugPrint("productController: ${productIdController.text}");
    if (fieldNameController.text.ext.isNotNullOrNoEmpty &&
        productIdController .text.ext.isNotNullOrNoEmpty &&
        dateTimeController.text.ext.isNotNullOrNoEmpty &&
        cityDistrictController.text.ext.isNotNullOrNoEmpty &&
        cityController.text.ext.isNotNullOrNoEmpty &&
        districtController.text.ext.isNotNullOrNoEmpty) {
      appLoading(context, true);
      var fieldData = FieldRequestModel(
        name: fieldNameController.text,
        active: true,
        outline: outline,
        cityId: selectedCityId,
        districtId: selectedDistrictId,
        bitkiId: int.tryParse(productIdController.text),
        ekimZamani: AppConstant.setDateFormat(context, dateTimeController.text),
        sulamadaGubreYapilacak: sulamaGubre,
        gubreTipleri: [gubreController.text],
      );
      debugPrint("fieldData: ${fieldData.toJson()}");
      var response = await FieldApiService.instance.post(fieldData);
      if (response.statusCode == 201 || response.statusCode == 200) {
        appLoading(context, false);
        Toastr.showSuccess("Tarlanız başarıyla eklendi.", context);
        ref.invalidate(fieldsProvider);
        ref.refresh(homeFutureProvider);
        Navigator.pop(context);
      } else {
        appLoading(context, false);
        Toastr.showError(response.message.toString(), context);
      }
    } else {
      if (fieldNameController.text.ext.isNullOrEmpty) {
        Toastr.showError("Tarla İsmi Boş Bırakılamaz", context);
      }
      if (productIdController.text.ext.isNullOrEmpty) {
        Toastr.showError("Mahsül Bilgisi Boş Bırakılamaz", context);
      }
      if (dateTimeController.text.ext.isNullOrEmpty) {
        Toastr.showError("Ekim Yapılma Tarihi Boş Bırakılamaz", context);
      }
      if (cityDistrictController.text.ext.isNullOrEmpty) {
        Toastr.showError("İl ve İlçe Bilgisi Boş Bırakılamaz", context);
      }
      if (cityController.text.ext.isNullOrEmpty) {
        Toastr.showError("İl Bilgisi Boş Bırakılamaz", context);
      }
      if (districtController.text.ext.isNullOrEmpty) {
        Toastr.showError("İlçe Bilgisi Boş Bırakılamaz", context);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    fieldNameController.dispose();
    productController.dispose();
    productIdController.dispose();
    dateTimeController.dispose();
    gubreController.dispose();
    cityDistrictController.dispose();
    cityController.dispose();
    districtController.dispose();
  }
}
