import 'package:flutter/material.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/image/image.dart';
import 'package:sizer/sizer.dart';

class PreferredAppBar extends StatefulWidget implements PreferredSizeWidget {
  const PreferredAppBar({super.key, required this.child, this.leading, this.actions, this.title});
  final Widget child;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? title;

  @override
  Size get preferredSize => Size(100.w, 67.w);
  @override
  State<PreferredAppBar> createState() => _PreferredAppBarState();
}

class _PreferredAppBarState extends State<PreferredAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: ColorManager.APPBARCOLOR,
      title: widget.title,
      flexibleSpace: ImageManager.instance.appbar,
      centerTitle: true,
      leading: widget.leading,
      actions: widget.actions,
      bottom: PreferredSize(preferredSize: widget.preferredSize, child: widget.child),
    );
  }
}
