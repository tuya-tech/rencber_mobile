import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';
import 'dart:io' show Platform;

class AppUpgrader extends StatelessWidget {
  const AppUpgrader({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      showLater: false,
      showIgnore: false,
      showReleaseNotes: true,
      dialogStyle: Platform.isAndroid ? UpgradeDialogStyle.material : UpgradeDialogStyle.cupertino,
      upgrader: Upgrader(
        debugDisplayAlways: false,
        debugLogging: kDebugMode,
      ),
      cupertinoButtonTextStyle: TextStyle(
        color: Colors.blue,
        fontSize: 16,
      ),
      child: child,
    );
  }
}
