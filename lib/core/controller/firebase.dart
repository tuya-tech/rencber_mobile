import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseInit {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  static final Set<String> _processedMessageIds = {};
  static const String _channelId = 'high_importance_channel';
  static const String _channelName = 'High Importance Notifications';

  /// Initialize Firebase Cloud Messaging
  static Future<void> initFcm() async {
    try {
      debugPrint('Initializing Firebase...');

      await _configureFcmPermissions();
      await _initializeLocalNotifications();

      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: false,
        badge: false,
        sound: false,
      );

      FirebaseMessaging.onMessage.listen((message) async {
        if (message.notification != null && !_processedMessageIds.contains(message.messageId)) {
          debugPrint('Handling a message: ${message.messageId}');
          _processedMessageIds.add(message.messageId ?? '');
          await notification(message);
        }
      });

      FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
    } catch (e) {
      debugPrint('Error initializing Firebase: $e');
      //Sentry.captureException(e);
    }
  }

  static Future<void> _configureFcmPermissions() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
  }

  static Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/launcher_icon');
    const iosSettings = DarwinInitializationSettings();

    await _notificationsPlugin.initialize(
      const InitializationSettings(android: androidSettings, iOS: iosSettings),
    );
  }

  @pragma('vm:entry-point')
  static Future<void> notification(RemoteMessage message) async {
    if (message.notification == null || message.messageId == null) return;

    const androidPlatform = AndroidNotificationDetails(
      _channelId,
      _channelName,
      importance: Importance.high,
      priority: Priority.high,
      enableLights: true,
      playSound: true,
      showWhen: true,
    );

    const iosPlatform = DarwinNotificationDetails(presentAlert: true, presentSound: true, sound: "default");

    const platform = NotificationDetails(android: androidPlatform, iOS: iosPlatform);

    await _notificationsPlugin.show(
      message.messageId.hashCode,
      message.notification?.title ?? "",
      message.notification?.body ?? "",
      platform,
    );
  }

  @pragma('vm:entry-point')
  static Future<void> _backgroundMessageHandler(RemoteMessage message) async {
    if (!_processedMessageIds.contains(message.messageId)) {
      debugPrint('Handling a background message: ${message.messageId}');
      _processedMessageIds.add(message.messageId ?? '');
    }
  }
}
