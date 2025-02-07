import 'package:flutter/material.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/image/image.dart';
import 'package:sizer/sizer.dart';

class SliverAppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? title;
  final Widget? appbarChild;
  final Widget? child;
  final double height;

  // Add key parameter to constructor
  const SliverAppBarCustom({
    super.key,
    this.child,
    this.title,
    this.leading,
    this.actions,
    this.appbarChild,
    this.height = 50,
  });

  @override
  Size get preferredSize => Size(100.w, height.w);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: ColorManager.GREEN,
          floating: false,
          pinned: false,
          expandedHeight: height.w,
          centerTitle: true,
          actions: actions ?? [Transform.translate(offset: const Offset(-10, 0), child: SizedBox(width: 10.w, height: 10.w, child: ImageManager.instance.appbarRightLogo))],
          leading: leading,
          title: title,
          flexibleSpace: FlexibleSpaceBar(background: ImageManager.instance.splashBg),
          bottom: PreferredSize(preferredSize: preferredSize, child: appbarChild ?? const SizedBox.shrink()),
        ),
        child != null
            ? SliverList(
                delegate: SliverChildListDelegate(
                  [child!],
                ),
              )
            : const SliverToBoxAdapter(child: SizedBox.shrink()),
      ],
    );
  }
}
