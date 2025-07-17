import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:sizer/sizer.dart';

class AppReview extends StatelessWidget {
  const AppReview({super.key, this.onTap});
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 8.w,
        decoration: BoxDecoration(
          color: ColorManager.buttonBgGreen.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("İncele", style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.buttonBgGreen)),
            IconManager.instance.customIcon(Icons.arrow_forward_sharp, color: ColorManager.buttonBgGreen, sizeW: 5),
          ],
        ),
      ),
    );
  }
}
