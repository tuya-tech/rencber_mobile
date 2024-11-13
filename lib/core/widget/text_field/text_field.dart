import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:kartal/kartal.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/image/image.dart';
import 'package:sizer/sizer.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({super.key, required this.fieldName, this.isPhoneNumber = false, this.hintText = "", this.labelText = "", required this.controller, this.keyboardType = TextInputType.text, this.inputFormatters = const [], this.textInputAction = TextInputAction.next, this.obscureText = false});
  final String fieldName;
  final bool isPhoneNumber;
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final TextInputAction textInputAction;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: fieldName,
      controller: controller,
      inputFormatters: isPhoneNumber ? [MaskTextInputFormatter(mask: '(###) ### ## ##')] : inputFormatters,
      keyboardType: isPhoneNumber ? TextInputType.phone : keyboardType,
      style: context.general.textTheme.titleMedium,
      textInputAction: textInputAction,
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Bu alan boş bırakılamaz";
        }
        if (isPhoneNumber) {
          if (value.length < 14) {
            return "Geçerli bir telefon numarası giriniz";
          }
        }
        return null;
      },
      decoration: InputDecoration(
        prefix: isPhoneNumber
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [ImageManager.instance.trFlag, context.sized.emptySizedWidthBoxLow, SizedBox(width: 2.w, height: 6.w, child: const VerticalDivider(color: ColorManager.GREEN)), const Text("+90 ")],
              )
            : null,
        labelText: labelText,
        hintText: hintText,
        labelStyle: context.general.textTheme.labelLarge,
        floatingLabelBehavior: FloatingLabelBehavior.always,
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
    );
  }
}
