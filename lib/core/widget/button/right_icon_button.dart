import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';

class AppRightIconButton extends StatelessWidget {
  const AppRightIconButton({super.key, this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      icon: Row(
        children: [
          Text('Tümünü Gör', style: context.general.textTheme.bodyLarge?.copyWith(color: ColorManager.greyColor)),
          IconManager.instance.customIcon(Icons.chevron_right_outlined, color: ColorManager.greyColor, sizeW: 6),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
