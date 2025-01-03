// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/core/cache/secure_storage.dart';
import 'package:rencber_mobile/core/constants/constant/constant.dart';
import 'package:rencber_mobile/core/widget/loading/loading.dart';
import 'package:rencber_mobile/core/widget/toastr/toastr.dart';
import 'package:rencber_mobile/features/profile/view/profile_edit.dart';
import 'package:rencber_mobile/product/models/user/user_request.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/product/provider/user/user_provider.dart';
import 'package:rencber_mobile/product/services/user/user.dart';

mixin ProfileEditMixin on ConsumerState<ProfileEditView> {
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController genderController;
  late final TextEditingController dateTimeController;
  late final TextEditingController mailController;
  late final TextEditingController cityDistrictController;
  late final TextEditingController cityController;
  late final TextEditingController districtController;
  late final TextEditingController addressController;
  bool phoneApproved = false;
  int selectedCityId = 0;
  int selectedDistrictId = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialData();
    });
    nameController = TextEditingController();
    phoneController = TextEditingController();
    genderController = TextEditingController();
    dateTimeController = TextEditingController();
    mailController = TextEditingController();
    cityDistrictController = TextEditingController();
    cityController = TextEditingController();
    districtController = TextEditingController();
    addressController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    genderController.dispose();
    dateTimeController.dispose();
    mailController.dispose();
    cityDistrictController.dispose();
    cityController.dispose();
    districtController.dispose();
    addressController.dispose();
  }

  void initialData() {
    phoneApproved = widget.userResponse.phoneApproved ?? false;
    nameController.text = "${widget.userResponse.name} ${widget.userResponse.surname}";
    phoneController.text = widget.userResponse.phone ?? "";
    genderController.text = genderByEng(widget.userResponse.gender ?? "");
    dateTimeController.text = widget.userResponse.birthday ?? "";
    debugPrint("birthday: ${widget.userResponse.birthday}");
    debugPrint("birthday: ${dateTimeController.text}");
    mailController.text = widget.userResponse.email ?? "";
    cityDistrictController.text = "${widget.userResponse.city?.name} / ${widget.userResponse.district?.name}";
    cityController.text = widget.userResponse.city?.name ?? "";
    districtController.text = widget.userResponse.district?.name ?? "";
    addressController.text = widget.userResponse.detailAddress ?? "";
    selectedCityId = widget.userResponse.city?.id ?? 0;
    selectedDistrictId = widget.userResponse.district?.id ?? 0;
  }

  String genderByEng(String gender) {
    switch (gender) {
      case "Erkek":
        return "MALE";
      case "Kadın":
        return "FEMALE";
      case "MALE":
        return "Erkek";
      case "FEMALE":
        return "Kadın";
      default:
        return "";
    }
  }

  void onMyInfo(BuildContext context, WidgetRef ref) async {
    debugPrint("asdas");
    if (nameController.text.ext.isNotNullOrNoEmpty &&
        phoneController.text.ext.isNotNullOrNoEmpty &&
        genderController.text.ext.isNotNullOrNoEmpty &&
        dateTimeController.text.ext.isNotNullOrNoEmpty &&
        mailController.text.ext.isNotNullOrNoEmpty &&
        cityDistrictController.text.ext.isNotNullOrNoEmpty &&
        addressController.text.ext.isNotNullOrNoEmpty) {
      appLoading(context, true);
      var userId = await SecureStorage.instance.readSecureData("userId");
      var response = await UserApiService.instance.post(UserRequestModel(
        id: int.tryParse(userId ?? "0") ?? 0,
        phone: phoneController.text,
        name: nameController.text.split(" ")[0],
        surname: nameController.text.split(" ")[1],
        cityId: selectedCityId,
        districtId: selectedDistrictId,
        gender: genderByEng(genderController.text),
        sendAd: widget.userResponse.sendAd,
        birthday: AppConstant.setDateFormat(context, dateTimeController.text),
        detailAddress: addressController.text,
        email: mailController.text,
      ));
      if (response.data != null && response.statusCode == 200) {
        appLoading(context, false);
        ref.refresh(userIdFutureProvider);
      } else {
        appLoading(context, false);
        Toastr.showError(response.message.toString(), context);
      }
    } else {
      if (nameController.text.ext.isNullOrEmpty) {
        Toastr.showError("Ad Soyad Boş Bırakılamaz", context);
      } else if (phoneController.text.ext.isNullOrEmpty) {
        Toastr.showError("Telefon Numarası Boş Bırakılamaz", context);
      } else if (genderController.text.ext.isNullOrEmpty) {
        Toastr.showError("Cinsiyet Boş Bırakılamaz", context);
      } else if (dateTimeController.text.ext.isNullOrEmpty) {
        Toastr.showError("Doğum Tarihi Giriniz ", context);
      } else if (mailController.text.ext.isNullOrEmpty) {
        Toastr.showError("E-Posta Giriniz", context);
      } else if (cityDistrictController.text.ext.isNullOrEmpty) {
        Toastr.showError("İl/İlçe Giriniz", context);
      } else if (addressController.text.ext.isNullOrEmpty) {
        Toastr.showError("Adres Giriniz", context);
      }
    }
  }
}
