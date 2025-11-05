import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/models/notification/notification_request.dart';
import 'package:rencber_mobile/product/models/notification/notification_response.dart';
import 'package:rencber_mobile/product/services/notification/notification.dart';

// Fetch all notifications
final notificationBildirimFutureProvider = FutureProvider.autoDispose<BaseResponseModel<List<NotificationResponseModel>>>(
  (ref) async {
    return NotificationApiService.instance.getNotificationList();
  },
);

// Notification Settings List
final notificationFutureProvider = FutureProvider.autoDispose<BaseResponseModel<List<NotificationRequestModel>>>(
  (ref) async {
    return NotificationApiService.instance.getNotificationSettingsList();
  },
);

// NEW: StateNotifier for performing update actions (mark read, process, etc.)
class NotificationNotifier extends StateNotifier<AsyncValue<void>> {
  NotificationNotifier(this._service) : super(const AsyncData(null));

  final NotificationApiService _service;

  Future<void> updateNotification({
    required int id,
    bool? read,
    bool? processed,
    String? response,
  }) async {
    try {
      state = const AsyncLoading();
      await _service.updateNotification(
        id: id,
        read: read,
        processed: processed,
        userResponse: response,
      );
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

// Provider for update operations
final notificationUpdateProvider =
    StateNotifierProvider<NotificationNotifier, AsyncValue<void>>(
  (ref) => NotificationNotifier(NotificationApiService.instance),
);
