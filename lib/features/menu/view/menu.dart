import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/constants/image/image.dart';
import 'package:rencber_mobile/features/menu/mixin/menu_mixin.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class MenuView extends StatelessWidget with MenuMixin {
  MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.BGCOLOR,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorManager.APPBARCOLOR,
        title: Text("Menü", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.WHITE)),
        flexibleSpace: ImageManager.instance.appbar,
        centerTitle: true,
        toolbarHeight: 10.w,
        actions: [Transform.translate(offset: const Offset(-10, 0), child: ImageManager.instance.appbarRightLogo)],
        bottom: PreferredSize(preferredSize: Size(100.w, 20.w), child: const SizedBox.shrink()),
      ),
      body: GridView.builder(
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
    );
  }
}
