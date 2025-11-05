import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/constant/constant.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/core/widget/loading/loading.dart';
import 'package:rencber_mobile/core/widget/toastr/toastr.dart';
import 'package:rencber_mobile/product/provider/field/field.dart';
import 'package:rencber_mobile/product/provider/home/home_provider.dart';
import 'package:rencber_mobile/product/provider/notification/notification.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_error.dart';
import 'package:rencber_mobile/product/services/field/field_islem_service.dart';
import 'package:sizer/sizer.dart';

class NotificationView extends ConsumerStatefulWidget {
  const NotificationView({super.key});

  @override
  ConsumerState<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends ConsumerState<NotificationView> {
  /// Bildirim tıklandığında yapılacak işlem
  Future<void> _onNotificationTap(BuildContext context, dynamic item) async {
    debugPrint("Bildirim seçildi -> ID: ${item.id}, Başlık: ${item.title}");

    final notifier = ref.read(notificationUpdateProvider.notifier);
    bool updateRead = true;
    if (item.tip == 'SORU') {
      final response = await _showQuestionDialog(item.title, item.message);

      debugPrint("User Response: $response");

      if (item.kategori == 'OTLANMA') {
        Toastr.showSuccess(
            "Cevabınız için teşekkürler! Otlanma işlemi kaydediliyor.",
            context);
        return;
      } else if (item.kategori == 'SULAMA' ||
          item.kategori == 'KATI_GUBRELEME' ||
          item.kategori == 'SIVI_GUBRELEME' ||
          item.kategori == 'ILACLAMA' ||
          item.kategori == 'CAPALAMA') {
        if (response == true) {
          var response = await FieldIslemApiService.instance.post(
            item.kategori,
            true,
            item.referenceId,
            AppConstant.setDateTimeFormat(
                context, "yyyy-MM-dd", DateTime.now().toString()),
          );

          if (response.statusCode == 201 && context.mounted) {
            // ref.invalidate(fieldIdFutureProvider(widget.fieldId));
            ref.invalidate(fieldIdFutureProvider(item.referenceId));
            ref.invalidate(homeFutureProvider);

            Toastr.showSuccess("İşleminiz başarıyla eklendi.", context);
          } else {
            Toastr.showError(
                item.kategori + " için cevabınız kaydedilemedi!", context);
          }
        } else {
          await notifier.updateNotification(id: item.id, read: true);
        }
      } else if (item.kategori == 'BUYUME') {
        Toastr.showSuccess(
            "Büyüme işlemi için lütfen uygulama üzerinden manuel olarak işlem ekleyiniz.",
            context);
      }
    } else if (item.kategori == 'HABER' || item.kategori == 'URUN') {
      if (item.referenceId != null) {
        // Navigator.pushNamed(
        //   context,
        //   '/${item.kategori}Detail',
        //   arguments: item.referenceId,
        // );
      }
    }

// await notifier.updateNotification(
    //   id: item.id,
    //   read: true,
    //   processed: true,
    //   response: "evet",
    // );

   await notifier.updateNotification(id: item.id, read: true);
    ref.invalidate(notificationBildirimFutureProvider);
  }

  /// Soru tipi bildirim için popup
  Future<bool?> _showQuestionDialog(String? title, String? message) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title ?? "Soru"),
        content: Text(message ?? "Bir seçim yapınız."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Hayır"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Evet"),
          ),
        ],
      ),
    );
  }

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
                        final isProcessed = item.processed == true;
                        final isQuestion = item.tip == 'SORU';

                        return Opacity(
                          opacity: isProcessed || !isUnread
                              ? 0.3
                              : 1.0, // İşlenmiş olanlar soluk görünsün
                          child: Container(
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
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () => !isProcessed
                                  ? _onNotificationTap(context, item)
                                  : null,
                              child: ListTile(
                                leading: Icon(
                                  isUnread
                                      ? isQuestion ? Icons.question_mark : Icons.notifications_active_outlined
                                      : isQuestion ? Icons.question_mark_outlined : Icons.notifications_none_outlined,
                                  color: isUnread
                                      ? ColorManager.buttonBgGreen
                                      : ColorManager.greyColor,
                                  size: 24,
                                ),
                                title: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.title ?? "Başlık Yok",
                                        style: context
                                            .general.textTheme.titleMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.black,
                                        ),
                                      ),
                                    ),
                                    if (isQuestion &&
                                        !isProcessed) // soru tipinde görsel ipucu
                                      const Icon(
                                        Icons.touch_app_outlined,
                                        color: Colors.orange,
                                        size: 24,
                                      ),
                                  ],
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    item.message ?? "Açıklama bulunamadı.",
                                    style: context.general.textTheme.bodyMedium
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
                            ),
                          ),
                        );
                      })
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.notifications_off_outlined,
                                color: ColorManager.greyColor, size: 48),
                            SizedBox(height: 8),
                            Text(
                              "Bildirim Bulunamadı",
                              style: TextStyle(
                                color: ColorManager.black,
                                fontSize: 16,
                              ),
                            ),
                          ],
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
