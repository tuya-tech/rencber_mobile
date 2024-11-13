import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/button/eleveted_button.dart';
import 'package:rencber_mobile/core/widget/checkbox/checkbox.dart';
import 'package:rencber_mobile/core/widget/dropdown/main_dropdown.dart';
import 'package:rencber_mobile/core/widget/text_field/text_field.dart';
import 'package:rencber_mobile/core/widget/toastr/toastr.dart';
import 'package:rencber_mobile/features/register/mixin/register_mixin.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> with RegisterMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.BGCOLOR,
      appBar: const AppBarBackButton(),
      body: Padding(
        padding: context.padding.horizontalNormal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hoşgeldiniz", style: context.general.textTheme.titleLarge),
            context.sized.emptySizedHeightBoxLow,
            Text("Kayıt Olun", style: context.general.textTheme.headlineSmall),
            context.sized.emptySizedHeightBoxLow3x,
            FormBuilder(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(fieldName: "phoneNumber", controller: phoneController, isPhoneNumber: true, labelText: "Cep Telefonu Numaranız"),
                  context.sized.emptySizedHeightBoxLow3x,
                  AppTextField(fieldName: "nameSurname", controller: nameSurnameController, labelText: "Ad - Soyad", hintText: "Adınız Soyadınız", inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))]),
                  context.sized.emptySizedHeightBoxLow3x,
                  Row(children: [const Expanded(child: SelectCity()), context.sized.emptySizedWidthBoxLow3x, const Expanded(child: SelectDistrict())]),
                  context.sized.emptySizedHeightBoxLow3x,
                  Text("Cinsiyetiniz", style: context.general.textTheme.titleLarge),
                  AppCheckBox(
                    multiSelect: true,
                    items: const ["Kadın", "Erkek"],
                    isCircular: true,
                    onChanged: (value) {
                      setGender(value);
                    },
                  ),
                  context.sized.emptySizedHeightBoxLow3x,
                  AppCheckBox(
                    items: const ["Bana özel kampanya ve fısatlarında haberdar olmak istiyorum.", "Rençber Kişisel Verilerin Korunması ve işlenmesi şartlarını okudum ve kabul ediyorum."],
                    onChanged: (value) {
                      setChechBoxValue(value);
                    },
                  )
                ],
              ),
            ),
            context.sized.emptySizedHeightBoxLow,
            AppElevetedButton(
              buttonText: "Kayıt Ol",
              rightIconData: Icons.north_east,
              onPressed: () {
                if (formKey.currentState!.validate() && gender.ext.isNotNullOrNoEmpty && checkBoxValue[1]) {
                  context.push(RouterManager.phoneCode);
                } else {
                  gender.ext.isNullOrEmpty ? Toastr.showError("Lütfen Cinsiyet Seçiniz", context) : null;
                  checkBoxValue[1] == false ? Toastr.showError("Lütfen Onay Kutucuklarını Işaretleyiniz", context) : null;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SelectCity extends StatefulWidget {
  const SelectCity({super.key});
  @override
  State<SelectCity> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> with RegisterMixin {
  @override
  Widget build(BuildContext context) {
    return DropDownSearchField(
      textFormFieldvalidator: (value) {
        if (value.toString().ext.isNullOrEmpty) {
          return "Bu alan boş bırakılamaz";
        }
        return null;
      },
      controller: cityController,
      items: const ["Ankara", "İstanbul", "İzmir", "Antalya"],
      itemBuilder: (context, item) => Padding(padding: context.padding.low, child: Text(item, style: context.general.textTheme.titleMedium)),
      menuDecoration: BoxDecoration(
        color: ColorManager.WHITE,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 1, blurRadius: 1, offset: const Offset(0, 1)),
        ],
      ),
      textFormFieldstyle: context.general.textTheme.titleMedium,
      textFormFieldDecoration: InputDecoration(
        hintText: "İl Seçiniz",
        suffixIcon: IconManager.instance.customIcon(Icons.keyboard_arrow_down),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.GREEN),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.GREEN),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.GREEN),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.RED),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.RED),
        ),
      ),
      onChanged: (value) {
        cityController.text = value.toString();
      },
      onSelected: (value) {
        cityController.text = value.toString();
      },
    );
  }
}

class SelectDistrict extends StatefulWidget {
  const SelectDistrict({super.key});
  @override
  State<SelectDistrict> createState() => _SelectDistrictState();
}

class _SelectDistrictState extends State<SelectDistrict> with RegisterMixin {
  @override
  Widget build(BuildContext context) {
    return DropDownSearchField(
      textFormFieldvalidator: (value) {
        if (value.toString().ext.isNullOrEmpty) {
          return "Bu alan boş bırakılamaz";
        }
        return null;
      },
      controller: districtController,
      items: const ["Ankara", "İstanbul", "İzmir", "Antalya"],
      itemBuilder: (context, item) => Padding(padding: context.padding.low, child: Text(item, style: context.general.textTheme.titleMedium)),
      menuDecoration: BoxDecoration(
        color: ColorManager.WHITE,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 1, blurRadius: 1, offset: const Offset(0, 1)),
        ],
      ),
      textFormFieldstyle: context.general.textTheme.titleMedium,
      textFormFieldDecoration: InputDecoration(
        hintText: "İlçe Seçiniz",
        suffixIcon: IconManager.instance.customIcon(Icons.keyboard_arrow_down),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.GREEN),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.GREEN),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.GREEN),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.RED),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.RED),
        ),
      ),
      onChanged: (value) {
        districtController.text = value.toString();
      },
      onSelected: (value) {
        districtController.text = value.toString();
      },
    );
  }
}
