import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/button/eleveted_button.dart';
import 'package:rencber_mobile/core/widget/checkbox/checkbox.dart';
import 'package:rencber_mobile/core/widget/dropdown/city_dropdown.dart';
import 'package:rencber_mobile/core/widget/dropdown/district_dropdown.dart';
import 'package:rencber_mobile/core/widget/text_field/text_field.dart';
import 'package:rencber_mobile/features/register/mixin/register_mixin.dart';
import 'package:rencber_mobile/product/provider/location/location_provider.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> with RegisterMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.BGCOLOR,
      appBar: const AppBarBackButton(),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
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
                    Row(children: [
                      Expanded(
                        child: AppCityDropdown(
                          hintText: "İl Seçiniz",
                          controller: cityController,
                          onSelected: (value, cityId) {
                            setState(() {
                              cityController.text = value;
                              districtController.clear();
                              this.cityId = cityId;
                              ref.read(selectedCityIdProvider.notifier).notify(cityId);
                            });
                          },
                        ),
                      ),
                      context.sized.emptySizedWidthBoxLow3x,
                      Expanded(
                          child: AppDistrictDropdown(
                        hintText: "İlçe Seçiniz",
                        controller: districtController,
                        onSelected: (value, districtId) {
                          setState(() {
                            districtController.text = value;
                            this.districtId = districtId;
                          });
                        },
                      ))
                    ]),
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
                  onRegister();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
