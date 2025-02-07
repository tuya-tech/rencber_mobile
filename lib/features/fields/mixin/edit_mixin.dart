// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/constant/constant.dart';
import 'package:rencber_mobile/core/widget/loading/loading.dart';
import 'package:rencber_mobile/core/widget/toastr/toastr.dart';
import 'package:rencber_mobile/features/fields/view/edit_field.dart';
import 'package:rencber_mobile/product/models/field/field_request.dart';
import 'package:rencber_mobile/product/provider/home/home_provider.dart';
import 'package:rencber_mobile/product/services/field/field.dart';

mixin FieldEditMixin on ConsumerState<FieldEditView> {
  late final TextEditingController fieldNameController;
  late final TextEditingController productController;
  late final TextEditingController dateTimeController;
  late final TextEditingController gubreController;
  late final TextEditingController cityDistrictController;
  late final TextEditingController cityController;
  late final TextEditingController districtController;
  bool sulamaGubre = false;
  bool outline = true;
  bool isActive = false;

  int selectedCityId = 0;
  int selectedDistrictId = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialData();
    });
    fieldNameController = TextEditingController();
    productController = TextEditingController();
    dateTimeController = TextEditingController();
    gubreController = TextEditingController();
    cityDistrictController = TextEditingController();
    cityController = TextEditingController();
    districtController = TextEditingController();
  }

  void initialData() {
    fieldNameController.text = widget.fieldData.name.toString();
    productController.text = widget.fieldData.bitkiName.toString();
    dateTimeController.text = widget.fieldData.ekimDate.toString();
    sulamaGubre = widget.fieldData.sulamadaGubreYapilacak ?? false;
    gubreController.text = widget.fieldData.gubreTipi ?? "";
    cityDistrictController.text = "${widget.fieldData.city?.name} / ${widget.fieldData.district?.name}";
    cityController.text = widget.fieldData.city?.name ?? "";
    districtController.text = widget.fieldData.district?.name ?? "";
    selectedCityId = widget.fieldData.city?.id ?? 0;
    selectedDistrictId = widget.fieldData.district?.id ?? 0;
    isActive = widget.fieldData.active ?? false;
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
    if (fieldNameController.text.ext.isNotNullOrNoEmpty &&
        productController.text.ext.isNotNullOrNoEmpty &&
        dateTimeController.text.ext.isNotNullOrNoEmpty &&
        cityDistrictController.text.ext.isNotNullOrNoEmpty &&
        cityController.text.ext.isNotNullOrNoEmpty &&
        gubreController.text.ext.isNotNullOrNoEmpty &&
        districtController.text.ext.isNotNullOrNoEmpty) {
      appLoading(context, true);
      var fieldData = FieldRequestModel(
        id: widget.fieldData.id,
        name: fieldNameController.text,
        active: isActive,
        outline: outline,
        cityId: selectedCityId,
        districtId: selectedDistrictId,
        bitkiId: 1,
        ekimZamani: AppConstant.setDateFormat(context, dateTimeController.text),
        sulamadaGubreYapilacak: sulamaGubre,
        gubreTipi: gubreController.text,
      );
      var response = await FieldApiService.instance.put(fieldData);
      if (response.data != null && response.statusCode == 201) {
        appLoading(context, false);
        Navigator.pop(context);
        Toastr.showSuccess("Tarlanız başarıyla düzenlendi.", context);
        //isActive == false ? await SecureStorage.instance.writeFieldModel("fieldData", fieldData) : null;
        ref.refresh(homeFutureProvider);
      } else {
        appLoading(context, false);
        Toastr.showError(response.data.code, context);
      }
    } else {
      if (fieldNameController.text.ext.isNullOrEmpty) {
        Toastr.showError("Tarla İsmi Boş Bırakılamaz", context);
      }
      if (productController.text.ext.isNullOrEmpty) {
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
    dateTimeController.dispose();
    gubreController.dispose();
    cityDistrictController.dispose();
    cityController.dispose();
    districtController.dispose();
  }
}
