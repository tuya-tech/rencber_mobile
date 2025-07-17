import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:sizer/sizer.dart';

class IslemlerWidget extends StatelessWidget {
  const IslemlerWidget({super.key, required this.title, required this.image, required this.borderColor, this.onTap});
  final String title;
  final Widget image;
  final Color borderColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 25.w,
        width: 25.w,
        child: Card(
          color: ColorManager.bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: borderColor, width: 1.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              image,
              context.sized.emptySizedHeightBoxLow,
              Text(title, style: context.general.textTheme.labelLarge?.copyWith(color: borderColor)),
            ],
          ),
        ),
      ),
    );
  }
}
