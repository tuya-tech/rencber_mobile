import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:sizer/sizer.dart';

class NotificationView extends ConsumerStatefulWidget {
  const NotificationView({super.key});

  @override
  ConsumerState<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends ConsumerState<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.BGCOLOR,
      body: SliverAppBarCustom(
        leading: const AppBarBackButton(),
        height: 5,
        title: Text("Bildirimlerim", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.WHITE)),
        child: Padding(
          padding: context.padding.verticalLow + context.padding.horizontalNormal,
          child: SizedBox(
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight - context.padding.verticalLow.vertical,
            child: ListView.builder(
              padding: context.padding.onlyBottomHigh * 3,
              itemCount: 9,
              itemBuilder: (context, index) {
                return Container(
                  height: 25.w,
                  decoration: const BoxDecoration(
                    color: ColorManager.WHITE,
                    border: Border(
                      top: BorderSide(color: ColorManager.BORDERGRAY, width: 0.5),
                      bottom: BorderSide(color: ColorManager.BORDERGRAY, width: 0.5),
                    ),
                    //borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    splashColor: ColorManager.WHITE,
                    tileColor: ColorManager.WHITE,
                    onTap: () {},
                    title: Text("Bildirim Başlığı", style: context.general.textTheme.titleMedium),
                    subtitle: Text("Bildirim Açıklaması", style: context.general.textTheme.bodyLarge),
                    trailing: Text("12:00", style: context.general.textTheme.bodyLarge),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
