import 'package:flutter/material.dart';

void appLoading(BuildContext context, bool isLoading) {
  if (isLoading) {
    showDialog(
      context: context,
      barrierColor: Colors.white.withValues(alpha: 0.5),
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
  if (!isLoading) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
