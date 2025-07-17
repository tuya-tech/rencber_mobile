import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/widget/button/eleveted_button.dart';
import 'package:rencber_mobile/core/widget/loading/loading.dart';
import 'package:rencber_mobile/core/widget/text_field/text_field.dart';
import 'package:rencber_mobile/features/valide/mixin/valide_code_mixin.dart';
import 'package:rencber_mobile/product/services/login/login.dart';

class ValideCodeView extends StatefulWidget {
  const ValideCodeView({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  State<ValideCodeView> createState() => _ValideCodeViewState();
}

class _ValideCodeViewState extends State<ValideCodeView> with ValideCodeMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      appBar: AppBar(backgroundColor: Colors.transparent),
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
                  AppTextField(
                    fieldName: "valideCodeNumber",
                    controller: valideCodeController,
                    labelText: "Sms Kodu",
                    obscureText: true,
                    maxLength: 6,
                  ),
                ],
              ),
            ),
            context.sized.emptySizedHeightBoxLow3x,
            AppElevetedButton(
              buttonText: "Giriş Yap",
              rightIconData: Icons.north_east,
              onPressed: () {
                onValide();
              },
            ),
            context.sized.emptySizedHeightBoxLow,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${(second ~/ 60).toString()}:${(second % 60).toString().padLeft(2, '0')}", style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.greyColor)),
                TextButton(
                  onPressed: () async {
                    appLoading(context, true);
                    var response = await LoginApiService.instance.loginRequest(phoneNumberFormatter(widget.phoneNumber));
                    debugPrint(response.data.toString());
                    if (response.data != null && context.mounted) {
                      appLoading(context, false);
                    } else {
                      context.mounted ? appLoading(context, false) : null;
                    }
                  },
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text("Tekrar Gönder", style: context.general.textTheme.bodyMedium?.copyWith(color: ColorManager.green)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
