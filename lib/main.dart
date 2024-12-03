import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/core/controller/firebase.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/core/theme/theme.dart';
import 'package:rencber_mobile/firebase_options.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseInit.initFcm();
  EasyLocalization.logger.enableBuildModes = [];
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('tr'), Locale('en')],
      path: 'assets/lang',
      fallbackLocale: const Locale('tr'),
      child: const ProviderScope(child: MyApp()),
    ),
  );
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
            title: 'Rencber',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routerConfig: RouterManager.instance.router,
            theme: appTheme(context),
            showPerformanceOverlay: false,
          );
        },
      ),
    );
  }
}
