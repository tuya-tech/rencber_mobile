import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/models/notification/notification_request.dart';
import 'package:rencber_mobile/product/models/notification/notification_response.dart';
import 'package:rencber_mobile/product/services/notification/notification.dart';

final notificationFutureProvider = FutureProvider.autoDispose<BaseResponseModel<List<NotificationRequestModel>>>(
  (ref) async {
    return NotificationApiService.instance.get();
  },
);

final notificationBildirimFutureProvider = FutureProvider.autoDispose<BaseResponseModel<List<NotificationResponseModel>>>(
  (ref) async {
    return NotificationApiService.instance.getNotification();
  },
);
