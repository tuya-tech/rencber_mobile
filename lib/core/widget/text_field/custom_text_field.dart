import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:kartal/kartal.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:sizer/sizer.dart';

class AppCustomTextField extends StatefulWidget {
  const AppCustomTextField(
      {super.key, required this.fieldName, this.isPhoneNumber = false, this.hintText = "", this.labelText = "", required this.controller, this.keyboardType = TextInputType.text, this.inputFormatters = const [], this.obscureText = false, this.maxLength, this.phoneApproved, this.buttonOnTap});
  final String fieldName;
  final bool isPhoneNumber;
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final bool obscureText;
  final int? maxLength;
  final bool? phoneApproved;
  final void Function()? buttonOnTap;

  @override
  State<AppCustomTextField> createState() => _AppCustomTextFieldState();
}

class _AppCustomTextFieldState extends State<AppCustomTextField> {
  late FocusNode focusNode;
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: context.padding.low,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: context.padding.onlyLeftLow,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.labelText, style: context.general.textTheme.titleMedium),
                  // InkWell(
                  //     onTap: widget.buttonOnTap ??
                  //         () {
                  //           setState(() {
                  //             isEdit = !isEdit;
                  //             if (isEdit) {
                  //               WidgetsBinding.instance.addPostFrameCallback((_) {
                  //                 focusNode.requestFocus();
                  //               });
                  //             } else {
                  //               focusNode.unfocus();
                  //             }
                  //           });
                  //         },
                  //     child: IconManager.instance.customIcon(!isEdit ? Icons.edit_outlined : Icons.check)),
                ],
              ),
            ),
            InkWell(
              onTap: widget.buttonOnTap ??
                  () {
                    setState(() {
                      isEdit = !isEdit;
                      if (isEdit) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          focusNode.requestFocus();
                        });
                      } else {
                        focusNode.unfocus();
                      }
                    });
                  },
              child: FormBuilderTextField(
                focusNode: focusNode,
                autofocus: isEdit,
                name: widget.fieldName,
                enabled: isEdit,
                controller: widget.controller,
                inputFormatters: widget.isPhoneNumber ? [MaskTextInputFormatter(mask: '### ### ## ##')] : widget.inputFormatters,
                keyboardType: widget.isPhoneNumber ? TextInputType.phone : widget.keyboardType,
                style: context.general.textTheme.titleMedium,
                textInputAction: TextInputAction.done,
                obscureText: widget.obscureText,
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
                  hintText: widget.hintText,
                  contentPadding: EdgeInsets.only(left: 2.w),
                  disabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
              ),
            ),
            widget.phoneApproved == true
                ? Padding(
                    padding: context.padding.onlyLeftLow,
                    child: Container(
                      width: 25.w,
                      height: 6.w,
                      decoration: BoxDecoration(
                        color: ColorManager.lightGreen,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: context.padding.onlyLeftLow,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconManager.instance.customIcon(Icons.check, sizeW: 5, color: ColorManager.black),
                            context.sized.emptySizedWidthBoxLow,
                            Text("Onaylanmış", style: context.general.textTheme.bodyLarge?.copyWith(color: ColorManager.black)),
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
