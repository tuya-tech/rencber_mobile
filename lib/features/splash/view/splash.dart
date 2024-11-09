import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/image/image.dart';
import 'package:rencber_mobile/features/splash/mixin/splash_mixin.dart';
import 'package:sizer/sizer.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SplashMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.GREEN,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.center,
        children: [
          ImageManager.instance.splashBg,
          Positioned(top: 70.w, child: ImageManager.instance.logo),
          Positioned(top: 98.w, child: Text("Hoşgeldiniz", style: context.general.textTheme.displaySmall?.copyWith(color: ColorManager.WHITE))),
          Positioned(top: 155.w, child: const CircularProgressIndicator(color: ColorManager.WHITE)),
        ],
      ),
    );
  }
}
