import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/product/provider/navbar/navbar_provider.dart';

mixin MenuMixin on ConsumerWidget {
  List getMenuList(WidgetRef ref) {
    List menuList = [
      {
        "title": "Anasayfa",
        "icon": Icons.home_outlined,
        "onTap": () {
          ref.read(navbarSelectedProvider.notifier).notify(2);
        },
      },
      {
        "title": "Tavsiyeler",
        "icon": Icons.description_outlined,
        "onTap": () {
          ref.read(navbarSelectedProvider.notifier).notify(1);
        },
      },
      {
        "title": "Haberler",
        "icon": Icons.newspaper,
        "onTap": () {
          ref.read(navbarSelectedProvider.notifier).notify(3);
        },
      },
      {
        "title": "Tarlalarım",
        "icon": Icons.landscape_outlined,
        "onTap": "/tarla",
      },
      {
        "title": "Hava Durumu",
        "icon": Icons.wb_sunny_outlined,
        "onTap": "/news",
      },
      {
        "title": "Takvim",
        "icon": Icons.calendar_today_outlined,
        "onTap": "/news",
      },
      {
        "title": "Hesabım",
        "icon": Icons.person_2_outlined,
        "onTap": () {
          ref.read(navbarSelectedProvider.notifier).notify(4);
        }
      },
      {
        "title": "Bildirim",
        "icon": Icons.notifications_none_outlined,
        "onTap": "/account",
      },
    ];

    return menuList;
  }
}
