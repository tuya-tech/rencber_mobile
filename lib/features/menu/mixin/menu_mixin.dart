import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/product/provider/navbar/navbar_provider.dart';

mixin MenuMixin on ConsumerWidget {
  List getMenuList(WidgetRef ref) {
    List menuList = [
      {
        "title": "Anasayfa",
        "icon": "house",
        "onTap": () {
          ref.read(navbarSelectedProvider.notifier).notify(2);
        },
      },
      {
        "title": "Tavsiyeler",
        "icon": "tavsiye",
        "onTap": () {
          ref.read(navbarSelectedProvider.notifier).notify(1);
        },
      },
      {
        "title": "Haberler",
        "icon": "news",
        "onTap": () {
          ref.read(navbarSelectedProvider.notifier).notify(3);
        },
      },
      {
        "title": "Tarlalarım",
        "icon": "tarla",
        "onTap": () {
          ref.read(navbarSelectedProvider.notifier).notify(2);
        }
      },
      // {
      //   "title": "Hava Durumu",
      //   "icon": "hava",
      //   "onTap": "/news",
      // },
      {
        "title": "Takvim",
        "icon": "takvim",
        "onTap": () {
          ref.read(navbarSelectedProvider.notifier).notify(2);
        }
      },
      {
        "title": "Hesabım",
        "icon": "hesabım",
        "onTap": () {
          ref.read(navbarSelectedProvider.notifier).notify(4);
        }
      },
      {
        "title": "Bildirim",
        "icon": "noti",
        "onTap": "/account",
      },
    ];

    return menuList;
  }
}
