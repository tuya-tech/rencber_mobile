import 'package:flutter/material.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/core/theme/theme.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
      child: Sizer(
        builder: (BuildContext context, Orientation orientation, ScreenType screenType) {
          return MaterialApp.router(
            title: 'Oteller.com',
            debugShowCheckedModeBanner: false,
            // localizationsDelegates: context.localizationDelegates,
            // supportedLocales: context.supportedLocales,
            // locale: context.locale,
            routerConfig: RouterManager.instance.router,
            theme: appTheme(context),
            showPerformanceOverlay: false,
          );
        },
      ),
    );
  }
}
