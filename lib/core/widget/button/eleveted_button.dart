import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:sizer/sizer.dart';

class AppElevetedButton extends StatelessWidget {
  const AppElevetedButton({super.key, required this.buttonText, required this.onPressed, this.rightIconData, this.leftIconData, this.buttonwidth = 100, this.buttonHeight = 12, this.textStyle, this.buttonColor, this.borderColor, this.textColor});
  final String buttonText;
  final IconData? rightIconData;
  final IconData? leftIconData;
  final void Function()? onPressed;
  final double buttonwidth;
  final double buttonHeight;
  final TextStyle? textStyle;
  final Color? buttonColor;
  final Color? borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonwidth.w,
      height: buttonHeight.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? ColorManager.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: borderColor ?? ColorManager.green, width: 1),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leftIconData != null ? Padding(padding: context.padding.onlyRightLow, child: IconManager.instance.customIcon(leftIconData, color: ColorManager.white, sizeW: 6)) : const SizedBox.shrink(),
            Text(buttonText, style: textStyle ?? context.general.textTheme.titleMedium!.copyWith(color: textColor ?? ColorManager.white, fontWeight: FontWeight.bold, fontSize: 16.5.sp)),
            rightIconData != null ? Padding(padding: context.padding.onlyLeftLow, child: IconManager.instance.customIcon(rightIconData, color: textColor ?? ColorManager.white, sizeW: 6)) : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
