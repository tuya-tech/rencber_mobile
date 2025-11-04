import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/product/provider/notification/notification.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_error.dart';
import 'package:sizer/sizer.dart';

class NotificationView extends ConsumerStatefulWidget {
  const NotificationView({super.key});

  @override
  ConsumerState<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends ConsumerState<NotificationView> {
  @override
  Widget build(BuildContext context) {
    final notificationFuture = ref.watch(notificationBildirimFutureProvider);

    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: notificationFuture.when(
        data: (notificationData) {
          final notifications = notificationData.data ?? [];

          return SliverAppBarCustom(
            leading: const AppBarBackButton(),
            height: 5,
            title: Text(
              "Bildirimlerim",
              style: context.general.textTheme.headlineMedium
                  ?.copyWith(color: ColorManager.white),
            ),
            child: Padding(
              padding: context.padding.verticalLow +
                  context.padding.horizontalNormal,
              child: notifications.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 8.h),
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final item = notifications[index];
                        final isUnread = item.read == false;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: isUnread
                                ? ColorManager.appBarColor.withOpacity(0.15)
                                : ColorManager.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: ColorManager.greyColor,
                              width: 0.5,
                            ),
                          ),
                          child: ListTile(
                            leading: Icon(
                              isUnread
                                  ? Icons.notifications_active_outlined
                                  : Icons.notifications_none_outlined,
                              color: isUnread
                                  ? ColorManager.buttonBgGreen
                                  : ColorManager.greyColor,
                              size: 24,
                            ),
                            onTap: () {
                              debugPrint(
                                  "Bildirim seçildi -> ID: ${item.id}, Başlık: ${item.title}");
                            },
                            title: Text(
                              item.title ?? "Başlık Yok",
                              style: context.general.textTheme.titleMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.black,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                item.message ?? "Açıklama bulunamadı.",
                                style: context
                                    .general.textTheme.bodyMedium
                                    ?.copyWith(
                                  color: ColorManager.greyColor,
                                ),
                              ),
                            ),
                            trailing: Text(
                              item.kategori ?? "",
                              style: context.general.textTheme.labelMedium
                                  ?.copyWith(
                                color: ColorManager.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Text(
                          "Bildirim Bulunamadı",
                          style: TextStyle(color: ColorManager.black),
                        ),
                      ),
                    ),
            ),
          );
        },
        error: (error, stackTrace) {
          debugPrint("Error: $error");
          return DioErrorManager.dioError(error);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
