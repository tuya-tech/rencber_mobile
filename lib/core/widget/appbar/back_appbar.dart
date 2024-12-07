import 'package:flutter/material.dart';

class AppBarBackButton extends StatefulWidget implements PreferredSizeWidget {
  const AppBarBackButton({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<AppBarBackButton> createState() => _AppBarBackButtonState();
}

class _AppBarBackButtonState extends State<AppBarBackButton> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
    );
  }
}
