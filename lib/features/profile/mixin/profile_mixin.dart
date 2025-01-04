import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/features/profile/view/profile.dart';

mixin ProfileMixin on State<ProfileView> {
  List<Map<String, dynamic>> getProfileList(BuildContext context) {
    List<Map<String, dynamic>> profileList = [
      {
        "title": "Hesap Ayarları",
        "icon": IconManager.instance.customIcon(Icons.edit_outlined, sizeW: 8, color: ColorManager.BUTTONBGGREEN),
        "onTap": (user) {
          context.push(RouterManager.profileEdit, extra: user);
        },
      },
      {
        "title": "Rençber Hakkında",
        "icon": IconManager.instance.customIcon(Icons.info_outline, sizeW: 8, color: ColorManager.BUTTONBGGREEN),
        "onTap": (user) {
          context.push(RouterManager.about);
        },
      },
      {
        "title": "Bildirim Tercihleri",
        "icon": IconManager.instance.customIcon(Icons.notifications, sizeW: 8, color: ColorManager.BUTTONBGGREEN),
        "onTap": (user) {
          context.push(RouterManager.notificationSetting, extra: user);
        },
      },
      {
        "title": "KVKK",
        "icon": IconManager.instance.customIcon(Icons.lock, sizeW: 8, color: ColorManager.BUTTONBGGREEN),
        "onTap": (user) {
          context.push(RouterManager.kvkk);
        },
      },
      // {
      //   "title": "Çıkış Yap",
      //   "icon": IconManager.instance.customIcon(Icons.logout, sizeW: 8, color: ColorManager.BUTTONBGGREEN),
      //   "onTap": () {},
      // },
    ];
    return profileList;
  }
}
