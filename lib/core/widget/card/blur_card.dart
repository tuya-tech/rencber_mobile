import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BlurCard extends StatelessWidget {
  const BlurCard({super.key, required this.child, this.height = 90, this.width = 90});
  final Widget child;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        height: height.w,
        width: width.w,
        margin: EdgeInsets.all(1.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.09),
          borderRadius: BorderRadius.circular(16),
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
    );
  }
}
