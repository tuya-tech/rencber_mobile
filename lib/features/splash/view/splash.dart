import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/image/image.dart';
import 'package:rencber_mobile/features/splash/mixin/splash_mixin.dart';
import 'package:sizer/sizer.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> with SplashMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.green,
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
          Positioned(top: 98.w, child: Text("Hoş geldiniz", style: context.general.textTheme.displaySmall?.copyWith(color: ColorManager.white))),
          Positioned(top: 155.w, child: const CircularProgressIndicator(color: ColorManager.white)),
        ],
      ),
    );
  }
}
