// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/core/widget/loading/loading.dart';
import 'package:rencber_mobile/core/widget/toastr/toastr.dart';
import 'package:rencber_mobile/product/models/register/register_request.dart';
import 'package:rencber_mobile/product/services/register/register.dart';

mixin RegisterMixin<T extends StatefulWidget> on State<T> {
  late final TextEditingController phoneController;
  late final TextEditingController nameSurnameController;
  late final TextEditingController cityController;
  late final TextEditingController districtController;
  final formKey = GlobalKey<FormBuilderState>();
  String? gender;
  List<bool> checkBoxValue = [false, false];
  int cityId = 0;
  int districtId = 0;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController(text: "(555)");
    nameSurnameController = TextEditingController();
    cityController = TextEditingController();
    districtController = TextEditingController();
  }

  void setGender(String value) {
    switch (value) {
      case "Erkek":
        gender = "MALE";
      case "Kadın":
        gender = "FEMALE";
      case "MALE":
        gender = "Erkek";
      case "FEMALE":
        gender = "Kadın";
      default:
        gender = "";
    }
  }

  void setChechBoxValue(List<bool> value) {
    checkBoxValue = value;
  }

  String phoneNumberFormatter(String value) {
    return value.replaceAll(RegExp(r'[()\s-]'), '');
  }

  void onRegister() async {
    debugPrint("cityId: $cityId, districtId: $districtId");
    debugPrint(gender.toString());
    debugPrint(phoneNumberFormatter(phoneController.text));
    if (formKey.currentState!.validate() && gender.ext.isNotNullOrNoEmpty && checkBoxValue[1]) {
      appLoading(context, true);
      RegisterRequestModel userData = RegisterRequestModel(phone: phoneNumberFormatter(phoneController.text), name: nameSurnameController.text, surname: nameSurnameController.text, cityId: cityId, districtId: districtId, gender: gender, sendAd: checkBoxValue[0], kvkk: checkBoxValue[1]);
      var response = await RegisterApiService.instance.post(userData);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        appLoading(context, false);
        context.push(RouterManager.phoneCode, extra: phoneController.text);
      } else {
        appLoading(context, false);
        Toastr.showError(response.data.code ?? "", context);
      }
    } else {
      gender.ext.isNullOrEmpty ? Toastr.showError("Lütfen Cinsiyet Seçiniz", context) : null;
      checkBoxValue[1] == false ? Toastr.showError("Lütfen Onay Kutucuklarını Işaretleyiniz", context) : null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    nameSurnameController.dispose();
    cityController.dispose();
    districtController.dispose();
  }
}
