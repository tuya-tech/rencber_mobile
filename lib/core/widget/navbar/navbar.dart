import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/features/error.dart';
import 'package:rencber_mobile/features/home/view/home.dart';
import 'package:rencber_mobile/features/menu/view/menu.dart';
import 'package:rencber_mobile/features/news/view/news.dart';
import 'package:sizer/sizer.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  late final PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        backgroundColor: ColorManager.WHITE,
        screens: NavbarModel.instance._usersItems,
        items: NavbarModel.instance.navBarsItems(),
        navBarStyle: NavBarStyle.style3,
        confineToSafeArea: true,
        controller: _controller,
      ),
    );
  }
}

class NavbarModel {
  NavbarModel._();
  static final instance = NavbarModel._();

  final List<Widget> _usersItems = [MenuView(), const ErrorView(), const HomeView(), const NewsView(), const HomeView()];
  final List<Widget> _guestItems = [MenuView(), const HomeView(), const HomeView(), const NewsView(), const HomeView()];

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(activeColorPrimary: Colors.transparent, inactiveColorPrimary: ColorManager.TEXTGREYCOLOR, activeColorSecondary: ColorManager.GREEN, iconSize: 7.w, icon: IconManager.instance.customIcon(Icons.menu), title: "Menü"),
      PersistentBottomNavBarItem(activeColorPrimary: Colors.transparent, inactiveColorPrimary: ColorManager.TEXTGREYCOLOR, activeColorSecondary: ColorManager.GREEN, iconSize: 7.w, icon: IconManager.instance.customIcon(Icons.description_outlined), title: "Tavsiyeler"),
      PersistentBottomNavBarItem(activeColorPrimary: Colors.transparent, inactiveColorPrimary: ColorManager.TEXTGREYCOLOR, activeColorSecondary: ColorManager.GREEN, iconSize: 7.w, icon: IconManager.instance.customIcon(Icons.home_outlined), title: "AnaSayfa"),
      PersistentBottomNavBarItem(activeColorPrimary: Colors.transparent, inactiveColorPrimary: ColorManager.TEXTGREYCOLOR, activeColorSecondary: ColorManager.GREEN, iconSize: 7.w, icon: IconManager.instance.customIcon(Icons.newspaper), title: "Haberler"),
      PersistentBottomNavBarItem(activeColorPrimary: Colors.transparent, inactiveColorPrimary: ColorManager.TEXTGREYCOLOR, activeColorSecondary: ColorManager.GREEN, iconSize: 7.w, icon: IconManager.instance.customIcon(Icons.person_2_outlined), title: "Hesabım"),
    ];
  }
}
