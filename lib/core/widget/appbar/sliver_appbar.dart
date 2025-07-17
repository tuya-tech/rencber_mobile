import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/image/image.dart';
import 'package:rencber_mobile/product/provider/navbar/navbar_provider.dart';
import 'package:rencber_mobile/product/provider/user/user_provider.dart';
import 'package:sizer/sizer.dart';

class SliverAppBarCustom extends ConsumerWidget implements PreferredSizeWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    var image = ref.watch(profileImageProvider) as String?;
    bool isValidImagePath(String? imagePath) {
      if (imagePath == null || imagePath.isEmpty) return false;
      try {
        final file = File(imagePath);
        return file.existsSync() && file.lengthSync() > 0;
      } catch (e) {
        debugPrint('Image validation error: $e');
        return false;
      }
    }

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: ColorManager.green,
          floating: false,
          pinned: false,
          expandedHeight: height.w,
          centerTitle: true,
          actions: actions ??
              [
                Transform.translate(
                    offset: const Offset(-10, 0),
                    child: InkWell(
                        onTap: () => ref.read(navbarSelectedProvider.notifier).notify(4),
                        child: SizedBox(
                            width: 10.w,
                            height: 10.w,
                            child: isValidImagePath(image)
                                ? ClipOval(
                                    child: Image.file(
                                      File(image!),
                                      height: 10.w,
                                      width: 10.w,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return ImageManager.instance.appbarRightLogo;
                                      },
                                    ),
                                  )
                                : ImageManager.instance.appbarRightLogo)))
              ],
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
