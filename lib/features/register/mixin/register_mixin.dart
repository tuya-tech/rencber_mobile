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

  var city = [
    "Adana",
    "Adıyaman",
    "Afyonkarahisar",
    "Ağrı",
    "Amasya",
    "Ankara",
    "Antalya",
    "Artvin",
    "Aydın",
    "Balıkesir",
    "Bilecik",
    "Bingöl",
    "Bitlis",
    "Bolu",
    "Burdur",
    "Bursa",
    "Çanakkale",
    "Çankırı",
    "Çorum",
    "Denizli",
    "Diyarbakır",
    "Edirne",
    "Elazığ",
    "Erzincan",
    "Erzurum",
    "Eskişehir",
    "Gaziantep",
    "Giresun",
    "Gümüşhane",
    "Hakkari",
    "Hatay",
    "Isparta",
    "Mersin",
    "İstanbul",
    "İzmir",
    "Kars",
    "Kastamonu",
    "Kayseri",
    "Kırklareli",
    "Kırşehir",
    "Kocaeli",
    "Konya",
    "Kütahya",
  ];

  var district = [
    "Adana",
    "Adıyaman",
    "Afyonkarahisar",
    "Ağrı",
    "Amasya",
    "Ankara",
    "Antalya",
    "Artvin",
    "Aydın",
    "Balıkesir",
    "Bilecik",
    "Bingöl",
    "Bitlis",
    "Bolu",
    "Burdur",
    "Bursa",
    "Çanakkale",
    "Çankırı",
    "Çorum",
    "Denizli",
    "Diyarbakır",
    "Edirne",
    "Elazığ",
    "Erzincan",
    "Erzurum",
    "Eskişehir",
    "Gaziantep",
    "Giresun",
    "Gümüşhane",
    "Hakkari",
    "Hatay",
    "Isparta",
    "Mersin",
    "İstanbul",
    "İzmir",
    "Kars",
    "Kastamonu",
    "Kayseri",
    "Kırklareli",
    "Kırşehir",
    "Kocaeli",
    "Konya",
    "Kütahya",
  ];

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController(text: "(555)");
    nameSurnameController = TextEditingController();
    cityController = TextEditingController();
    districtController = TextEditingController();
  }

  void setGender(String value) {
    gender = value;
  }

  void setChechBoxValue(List<bool> value) {
    checkBoxValue = value;
  }

  void setCityId(String value) {
    cityController.text = value;
    cityId = city.indexOf(value);
    debugPrint("CityId: $cityId");
    debugPrint("cityController: ${cityController.text}");
  }

  void setDistrictId(String value) {
    districtController.text = value;
    districtId = district.indexOf(value);
  }

  void onRegister() {
    if (formKey.currentState!.validate() && gender.ext.isNotNullOrNoEmpty && checkBoxValue[1]) {
      appLoading(context, true);
      RegisterRequestModel userData = RegisterRequestModel(phone: phoneController.text, name: nameSurnameController.text, surname: nameSurnameController.text, cityId: 1, districtId: 1, sendAd: checkBoxValue[0], kvkk: checkBoxValue[1], roles: [0]);
      RegisterApiService.instance.post(userData).then((value) {
        if (value.statusCode == 200) {
          appLoading(context, false);
          context.push(RouterManager.phoneCode);
        } else {
          appLoading(context, false);
          context.push(RouterManager.phoneCode);
          Toastr.showError("Kayıt Başarısız", context);
        }
      });
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
