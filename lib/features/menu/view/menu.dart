import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/features/menu/mixin/menu_mixin.dart';

// ignore: must_be_immutable
class MenuView extends StatelessWidget with MenuMixin {
  MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.BGCOLOR,
      body: SliverAppBarCustom(
        height: 15,
        title: Text("Menü", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.WHITE)),
        child: GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: menuList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Padding(
              padding: context.padding.low,
              child: Card(
                elevation: 0.5,
                color: ColorManager.WHITE,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconManager.instance.customIcon(menuList[index]["icon"], sizeW: 15, color: ColorManager.GREEN),
                    context.sized.emptySizedHeightBoxLow,
                    Text('${menuList[index]["title"]}', style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.GREEN)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
