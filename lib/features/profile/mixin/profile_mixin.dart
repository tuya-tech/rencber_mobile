import 'package:flutter/material.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/features/profile/view/profile.dart';

mixin ProfileMixin on State<ProfileView> {
  List<Map> profileList = [
    {
      "title": "Hesap Ayarları",
      "icon": IconManager.instance.customIcon(Icons.edit_outlined, sizeW: 8, color: ColorManager.BUTTONBGGREEN),
      "onTap": () {},
    },
    {
      "title": "Rençber Hakkında",
      "icon": IconManager.instance.customIcon(Icons.info_outline, sizeW: 8, color: ColorManager.BUTTONBGGREEN),
      "onTap": () {},
    },
    {
      "title": "Bildirim Tercihleri",
      "icon": IconManager.instance.customIcon(Icons.notifications, sizeW: 8, color: ColorManager.BUTTONBGGREEN),
      "onTap": () {},
    },
    {
      "title": "KVKK",
      "icon": IconManager.instance.customIcon(Icons.lock, sizeW: 8, color: ColorManager.BUTTONBGGREEN),
      "onTap": () {},
    },
    // {
    //   "title": "Çıkış Yap",
    //   "icon": IconManager.instance.customIcon(Icons.logout, sizeW: 8, color: ColorManager.BUTTONBGGREEN),
    //   "onTap": () {},
    // },
  ];
}
