import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:kartal/kartal.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/constants/image/image.dart';
import 'package:sizer/sizer.dart';

class AppTextField extends StatefulWidget {
  const AppTextField(
      {super.key, required this.fieldName, this.isPhoneNumber = false, this.hintText = "", this.labelText = "", required this.controller, this.keyboardType = TextInputType.text, this.inputFormatters = const [], this.textInputAction = TextInputAction.next, this.obscureText = false, this.maxLength});
  final String fieldName;
  final bool isPhoneNumber;
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final TextInputAction textInputAction;
  final bool obscureText;
  final int? maxLength;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: widget.fieldName,
      controller: widget.controller,
      inputFormatters: widget.isPhoneNumber ? [MaskTextInputFormatter(mask: '(###) ### ## ##')] : widget.inputFormatters,
      keyboardType: widget.isPhoneNumber ? TextInputType.phone : widget.keyboardType,
      style: context.general.textTheme.titleMedium,
      textInputAction: widget.textInputAction,
      obscureText: obscureText,
      maxLength: widget.maxLength,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Bu alan boş bırakılamaz";
        }
        if (widget.isPhoneNumber) {
          if (value.length < 14) {
            return "Geçerli bir telefon numarası giriniz";
          }
        }
        return null;
      },
      decoration: InputDecoration(
        prefix: widget.isPhoneNumber
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [ImageManager.instance.trFlag, context.sized.emptySizedWidthBoxLow, SizedBox(width: 2.w, height: 6.w, child: const VerticalDivider(color: ColorManager.green)), const Text("+90 ")],
              )
            : null,
        suffixIcon: widget.obscureText
            ? IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => setState(() => obscureText = !obscureText),
                icon: IconManager.instance.customIcon(obscureText ? Icons.visibility_off : Icons.visibility),
              )
            : null,
        labelText: widget.labelText,
        hintText: widget.hintText,
        labelStyle: context.general.textTheme.labelLarge,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.green),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.green),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.red),
        ),
      ),
    );
  }
}
