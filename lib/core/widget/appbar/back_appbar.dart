import 'package:flutter/material.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';

import 'package:sizer/sizer.dart';

class AppBarBackButton extends StatefulWidget implements PreferredSizeWidget {
  const AppBarBackButton({super.key, this.color});
  final Color? color;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<AppBarBackButton> createState() => _AppBarBackButtonState();
}

class _AppBarBackButtonState extends State<AppBarBackButton> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: ClipRRect(
        child: InkWell(
          onTap: () => Navigator.of(context).pop(),
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Container(
            margin: EdgeInsets.all(1.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 0.3.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.01),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 1.5.w),
              child: IconManager.instance.customIcon(Icons.arrow_back_ios, color: widget.color ?? ColorManager.WHITE),
            ),
          ),
        ),
      ),
    );
  }
}
