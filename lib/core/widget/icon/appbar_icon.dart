import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppbarIcon extends StatelessWidget {
  const AppbarIcon({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        debugPrint('AppbarIcon clicked');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: 10.w,
          width: 10.w,
          margin: EdgeInsets.all(1.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.09),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 0.3.w),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.01),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
