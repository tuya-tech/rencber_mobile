import 'package:flutter/material.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/image/image.dart';
import 'package:sizer/sizer.dart';

class SliverAppBarCustom extends StatefulWidget implements PreferredSizeWidget {
  const SliverAppBarCustom({super.key, required this.child, this.title, this.leading, this.actions, this.appbarChild, this.height = 50});
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? title;
  final Widget? appbarChild;
  final Widget child;
  final double height;

  @override
  Size get preferredSize => Size(100.w, height.w);

  @override
  State<SliverAppBarCustom> createState() => _SliverAppBarCustomState();
}

class _SliverAppBarCustomState extends State<SliverAppBarCustom> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: ColorManager.GREEN,
          floating: false,
          pinned: false,
          expandedHeight: widget.height.w,
          centerTitle: true,
          actions: widget.actions ?? [Transform.translate(offset: const Offset(-10, 0), child: SizedBox(width: 10.w, height: 10.w, child: ImageManager.instance.appbarRightLogo))],
          leading: widget.leading,
          title: widget.title,
          flexibleSpace: FlexibleSpaceBar(
            background: ImageManager.instance.splashBg,
          ),
          bottom: PreferredSize(preferredSize: widget.preferredSize, child: widget.appbarChild ?? const SizedBox.shrink()),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [widget.child],
          ),
        ),
      ],
    );
  }
}
