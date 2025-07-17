import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/image/image.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/features/menu/mixin/menu_mixin.dart';

// ignore: must_be_immutable
class MenuView extends ConsumerWidget with MenuMixin {
  MenuView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: SliverAppBarCustom(
        height: 15,
        title: Text("Menü", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.white)),
        child: GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: getMenuList(ref, context).length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1, crossAxisSpacing: 0, mainAxisSpacing: 0),
          itemBuilder: (context, index) {
            var menuList = getMenuList(ref, context);
            return Padding(
              padding: context.padding.low,
              child: InkWell(
                onTap: () => menuList[index]["onTap"](),
                child: Card(
                  elevation: 0.5,
                  color: ColorManager.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageManager.getMenuImage(menuList[index]["icon"]),
                      //IconManager.instance.customIcon(menuList[index]["icon"], sizeW: 15, color: ColorManager.green),
                      context.sized.emptySizedHeightBoxLow,
                      Text('${menuList[index]["title"]}', style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.green)),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
