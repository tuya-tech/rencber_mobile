// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rencber_mobile/core/widget/loading/loading.dart';
import 'package:rencber_mobile/features/profile/view/notification.dart';
import 'package:rencber_mobile/product/models/notification/notification_request.dart';
import 'package:rencber_mobile/product/services/notification/notification.dart';

mixin NotificationMixin on State<NotificationSettingView> {
  bool? allowNotifications;
  bool? allowSMS;
  bool? allowEmail;
  int? notificationId;

  void notificationAllow(bool? value) async {
    if (value == null) return;
    if (allowNotifications == value) return;
    appLoading(context, true);
    var response = await NotificationApiService.instance.put(NotificationRequestModel(id: notificationId, allowNotifications: value, allowSms: allowSMS, allowEmail: allowEmail));

    if (response.statusCode == 200) {
      setState(() {
        allowNotifications = value;
      });
      appLoading(context, false);
    } else {
      appLoading(context, false);
    }
  }

  void notificationSMS(bool? value) async {
    if (value == null) return;
    if (allowSMS == value) return;
    appLoading(context, true);
    var response = await NotificationApiService.instance.put(NotificationRequestModel(id: notificationId, allowNotifications: allowNotifications, allowSms: value, allowEmail: allowEmail));

    if (response.statusCode == 200) {
      setState(() {
        allowSMS = value;
      });
      appLoading(context, false);
    } else {
      appLoading(context, false);
    }
  }

  void notificationEmail(bool? value) async {
    if (value == null) return;
    if (allowEmail == value) return;
    appLoading(context, true);
    var response = await NotificationApiService.instance.put(NotificationRequestModel(id: notificationId, allowNotifications: allowNotifications, allowSms: allowSMS, allowEmail: value));

    if (response.statusCode == 200) {
      setState(() {
        allowEmail = value;
      });
      appLoading(context, false);
    } else {
      appLoading(context, false);
    }
  }
}
