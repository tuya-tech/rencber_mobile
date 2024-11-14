import 'package:flutter/material.dart';

mixin MenuMixin on StatelessWidget {
  List menuList = [
    {
      "title": "Anasayfa",
      "icon": Icons.home_outlined,
      "route": "/home",
    },
    {
      "title": "Tavsiyeler",
      "icon": Icons.description_outlined,
      "route": "/advice",
    },
    {
      "title": "Haberler",
      "icon": Icons.newspaper,
      "route": "/news",
    },
    {
      "title": "Tarlalarım",
      "icon": Icons.landscape_outlined,
      "route": "/tarla",
    },
    {
      "title": "Hava Durumu",
      "icon": Icons.wb_sunny_outlined,
      "route": "/news",
    },
    {
      "title": "Takvim",
      "icon": Icons.calendar_today_outlined,
      "route": "/news",
    },
    {
      "title": "Hesabım",
      "icon": Icons.person_2_outlined,
      "route": "/account",
    },
    {
      "title": "Bildirim",
      "icon": Icons.notifications_none_outlined,
      "route": "/account",
    },
  ];
}
