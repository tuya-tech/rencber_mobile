import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/constant/constant.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/core/widget/button/eleveted_button.dart';
import 'package:rencber_mobile/core/widget/date_picker/date_picker.dart';
import 'package:rencber_mobile/core/widget/dropdown/city_dropdown.dart';
import 'package:rencber_mobile/core/widget/dropdown/district_dropdown.dart';
import 'package:rencber_mobile/core/widget/dropdown/gender.dart';
import 'package:rencber_mobile/core/widget/text_field/custom_text_field.dart';
import 'package:rencber_mobile/features/profile/mixin/profile_edit.dart';
import 'package:rencber_mobile/product/models/user/user_response.dart';
import 'package:rencber_mobile/product/provider/location/location_provider.dart';
import 'package:sizer/sizer.dart';

class ProfileEditView extends ConsumerStatefulWidget {
  const ProfileEditView({super.key, required this.userResponse});
  final UserResponseModel userResponse;

  @override
  ConsumerState<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends ConsumerState<ProfileEditView> with ProfileEditMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.BGCOLOR,
      body: SliverAppBarCustom(
        height: 5,
        title: Text("Hesap Ayarları", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.WHITE)),
        leading: const AppBarBackButton(),
        child: Padding(
          padding: context.padding.normal + context.padding.onlyBottomHigh,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Giriş Kayıt Bilgileri", style: context.general.textTheme.headlineMedium),
              context.sized.emptySizedHeightBoxLow,
              AppCustomTextField(fieldName: "name", controller: nameController, hintText: "Adınız", labelText: "Ad*"),
              context.sized.emptySizedHeightBoxLow,
              AppCustomTextField(fieldName: "surname", controller: surNameController, hintText: "Soyadınız", labelText: "Soyad*"),
              context.sized.emptySizedHeightBoxLow,
              AppCustomTextField(fieldName: "phoneNumber", controller: phoneController, hintText: "Telefon Numaranız", labelText: "Telefon Numarası*", phoneApproved: phoneApproved, isPhoneNumber: true),
              context.sized.emptySizedHeightBoxLow,
              AppGender(genderController: genderController, labelText: "Cinsiyet*"),
              //AppCustomTextField(fieldName: "gender", controller: genderController, hintText: "Erkek", labelText: "Cinsiyet*"),
              context.sized.emptySizedHeightBoxLow3x,
              Text("Kişisel Bilgiler", style: context.general.textTheme.headlineMedium),
              context.sized.emptySizedHeightBoxLow,
              AppDatePicker(controller: dateTimeController, name: "dateTime", hintText: "--,--,----", labelText: "Doğum Tarihi*", initialValue: AppConstant.dateFormat(context, widget.userResponse.birthday)),
              //AppCustomTextField(fieldName: "dateTime", controller: nameController, hintText: "--,--,----", labelText: "Doğum Tarihi*"),
              context.sized.emptySizedHeightBoxLow,
              AppCustomTextField(fieldName: "mail", controller: mailController, hintText: "E-Posta Giriniz", labelText: "E-Posta Adresi*", keyboardType: TextInputType.emailAddress),
              context.sized.emptySizedHeightBoxLow,
              AppCustomTextField(
                fieldName: "city/district",
                controller: cityDistrictController,
                hintText: "İl / İlçe Seçiniz",
                labelText: "İl/İlçe*",
                buttonOnTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return UserSelectCityAndDistrict(
                        cityController: cityController,
                        districtController: districtController,
                        cityDistrictController: cityDistrictController,
                        initialCityId: widget.userResponse.city?.id ?? 0,
                        selectedCityId: 1,
                        onCitySelected: (val, value) {
                          setState(() {
                            districtController.text = "";
                            cityController.text = val;
                            selectedCityId = value;
                            ref.read(selectedCityIdProvider.notifier).notify(value);
                          });
                        },
                        onDistrictSelected: (val, value) {
                          districtController.text = val;
                          selectedDistrictId = value;
                        },
                      );
                    },
                  );
                },
              ),
              context.sized.emptySizedHeightBoxLow,
              AppCustomTextField(fieldName: "adress", controller: addressController, hintText: "Adresinizi Giriniz", labelText: "Detaylı Adres*"),
              context.sized.emptySizedHeightBoxLow3x,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppElevetedButton(buttonwidth: 30, buttonHeight: 9, buttonText: "Kaydet", onPressed: () => onMyInfo(context, ref)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserSelectCityAndDistrict extends ConsumerStatefulWidget {
  const UserSelectCityAndDistrict({super.key, required this.cityController, required this.districtController, required this.cityDistrictController, this.onCitySelected, this.onDistrictSelected, this.initialCityId = 0, this.selectedCityId = 0});
  final TextEditingController cityController;
  final TextEditingController districtController;
  final TextEditingController cityDistrictController;
  final void Function(String, int)? onCitySelected;
  final void Function(String, int)? onDistrictSelected;
  final int initialCityId;
  final int selectedCityId;

  @override
  ConsumerState<UserSelectCityAndDistrict> createState() => _UserSelectCityAndDistrictState();
}

class _UserSelectCityAndDistrictState extends ConsumerState<UserSelectCityAndDistrict> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorManager.WHITE,
      elevation: 0,
      content: SizedBox(
        height: 43.w,
        width: 100.w,
        child: Column(
          children: [
            context.sized.emptySizedHeightBoxLow,
            AppCityDropdown(
              hintText: "İl Seçiniz",
              controller: widget.cityController,
              onSelected: widget.onCitySelected,
            ),
            context.sized.emptySizedHeightBoxLow,
            AppDistrictDropdown(
              hintText: "İlçe Seçiniz",
              controller: widget.districtController,
              selectedCityId: widget.cityController.text.ext.isNotNullOrNoEmpty ? widget.selectedCityId : widget.initialCityId,
              onSelected: widget.onDistrictSelected,
            ),
            context.sized.emptySizedHeightBoxLow,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppElevetedButton(
                    buttonwidth: 30,
                    buttonHeight: 10,
                    buttonText: "Geri",
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                AppElevetedButton(
                  buttonwidth: 30,
                  buttonHeight: 10,
                  buttonText: "Tamam",
                  onPressed: () {
                    if (widget.cityController.text.ext.isNullOrEmpty || widget.districtController.text.ext.isNullOrEmpty) {
                      return;
                    }
                    widget.cityDistrictController.text = "${widget.cityController.text} / ${widget.districtController.text}";
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
