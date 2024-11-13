import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/button/eleveted_button.dart';
import 'package:rencber_mobile/core/widget/text_field/text_field.dart';
import 'package:rencber_mobile/features/register/mixin/phone_code_mixin.dart';

class PhoneCodeView extends StatefulWidget {
  const PhoneCodeView({super.key});

  @override
  State<PhoneCodeView> createState() => _PhoneCodeViewState();
}

class _PhoneCodeViewState extends State<PhoneCodeView> with PhoneCodeMixin {
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
            Text("Telefonu Doğrula", style: context.general.textTheme.headlineSmall),
            context.sized.emptySizedHeightBoxLow,
            Text("Lütfen cep telefonunuza gelen 6 haneli doğrulama kodunu giriniz.", style: context.general.textTheme.labelLarge),
            context.sized.emptySizedHeightBoxLow3x,
            FormBuilder(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(fieldName: "phoneCodeNumber", controller: phoneCodeController, labelText: "Sms Kodu", obscureText: true),
                ],
              ),
            ),
            context.sized.emptySizedHeightBoxLow3x,
            AppElevetedButton(
              buttonText: "Giriş Yap",
              rightIconData: Icons.north_east,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.go(RouterManager.login);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
