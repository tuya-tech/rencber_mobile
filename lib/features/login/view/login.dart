import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/core/widget/button/eleveted_button.dart';
import 'package:rencber_mobile/core/widget/text_field/text_field.dart';
import 'package:rencber_mobile/features/login/mixin/login_mixin.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with LoginMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.BGCOLOR,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Padding(
        padding: context.padding.horizontalNormal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hoşgeldiniz", style: context.general.textTheme.titleLarge),
            context.sized.emptySizedHeightBoxLow,
            Text("Giriş Yapın", style: context.general.textTheme.headlineSmall),
            context.sized.emptySizedHeightBoxLow3x,
            FormBuilder(key: formKey, child: AppTextField(fieldName: "phoneNumber", controller: phoneController, isPhoneNumber: true, labelText: "Cep Telefonu Numaranız")),
            context.sized.emptySizedHeightBoxLow3x,
            AppElevetedButton(buttonText: "Giriş Yap", rightIconData: Icons.north_east, onPressed: onLogin),
            context.sized.emptySizedHeightBoxLow,
            Row(
              children: [
                Text("Bir üyeliğiniz yok mu?", style: context.general.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                InkWell(onTap: () => context.push(RouterManager.register), child: Text(" Kayıt Olun", style: context.general.textTheme.titleMedium!.copyWith(color: ColorManager.GREEN, fontWeight: FontWeight.w600))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
