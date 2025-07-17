import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/features/profile/mixin/notification_mixin.dart';
import 'package:rencber_mobile/product/models/user/user_response.dart';
import 'package:rencber_mobile/product/provider/notification/notification.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_error.dart';

class NotificationSettingView extends ConsumerStatefulWidget {
  const NotificationSettingView({super.key, required this.userResponse});
  final UserResponseModel userResponse;

  @override
  ConsumerState<NotificationSettingView> createState() => _NotificationSettingViewState();
}

class _NotificationSettingViewState extends ConsumerState<NotificationSettingView> with NotificationMixin {
  @override
  Widget build(BuildContext context) {
    var notificationProvider = ref.watch(notificationFutureProvider);
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: notificationProvider.when(
        data: (notificationData) {
          notificationId = notificationData.data?.first.id;
          debugPrint("Notification Data: ${notificationData.data?.first.toJson()}");
          return SliverAppBarCustom(
            height: 5,
            title: Text("Bildirim Tercihleri", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.white)),
            leading: const AppBarBackButton(),
            child: Padding(
              padding: context.padding.normal + context.padding.onlyBottomHigh,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NotificationSwitch(
                    title: "Genel",
                    subtitle: "Anlık Bildirim Al",
                    initialValue: notificationData.data?.first.allowNotifications,
                    onChanged: (value) {
                      notificationAllow(value);
                    },
                  ),
                  context.sized.emptySizedHeightBoxLow,
                  NotificationSwitch(
                    title: "SMS",
                    subtitle: "SMS'lere izin ver",
                    initialValue: notificationData.data?.first.allowSms,
                    onChanged: (value) {
                      notificationSMS(value);
                    },
                  ),
                  context.sized.emptySizedHeightBoxLow,
                  NotificationSwitch(
                    title: "E-posta",
                    subtitle: "E-postalara izin ver",
                    initialValue: notificationData.data?.first.allowEmail,
                    onChanged: (value) {
                      notificationEmail(value);
                    },
                  ),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          debugPrint("Error: $error");
          return DioErrorManager.dioError(error);
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class NotificationSwitch extends StatelessWidget {
  const NotificationSwitch({super.key, required this.title, required this.subtitle, this.onChanged, this.initialValue});
  final String title;
  final String subtitle;
  final void Function(bool?)? onChanged;
  final bool? initialValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: context.padding.low,
        child: Column(
          children: [
            FormBuilderSwitch(
              name: "notificationSettings",
              title: Text(title, style: context.general.textTheme.labelLarge),
              subtitle: Padding(padding: context.padding.onlyTopLow, child: Text(subtitle, style: context.general.textTheme.titleMedium)),
              activeColor: ColorManager.green,
              activeTrackColor: ColorManager.green.withValues(alpha: 0.5),
              inactiveTrackColor: ColorManager.textGreyColor.withValues(alpha: 0.5),
              inactiveThumbColor: ColorManager.greyColor.withValues(alpha: 0.5),
              onChanged: onChanged,
              initialValue: initialValue,
              decoration: const InputDecoration(
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
