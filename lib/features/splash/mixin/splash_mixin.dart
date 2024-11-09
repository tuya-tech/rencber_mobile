import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/features/splash/view/splash.dart';

mixin SplashMixin on State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      context.go(RouterManager.login);
    });
  }
}
