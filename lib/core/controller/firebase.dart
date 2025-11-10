import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseInit {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final Set<String> _processedMessageIds = {};
  static const String _channelId = 'high_importance_channel';
  static const String _channelName = 'High Importance Notifications';

  /// Initialize Firebase Cloud Messaging
  static Future<void> initFcm() async {
    try {
      debugPrint('Initializing Firebase...');

      await _configureFcmPermissions();
      await _initializeLocalNotifications();

      if (Platform.isAndroid) {
        const androidChannel = AndroidNotificationChannel(
          _channelId,
          _channelName,
          description: 'Rencber önemli bildirim kanalı',
          importance: Importance.high,
        );
        await _notificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(androidChannel);
      }

      // Foreground bildirim ayarları
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // App açıkken gelen bildirim
      FirebaseMessaging.onMessage.listen((message) async {
        if (message.notification != null &&
            !_processedMessageIds.contains(message.messageId)) {
          debugPrint('Foreground mesaj alındı: ${message.messageId}');
          _processedMessageIds.add(message.messageId ?? '');
          await _showLocalNotification(message);
        }
      });

      // Kullanıcı bildirime tıkladığında (arka planda veya kapalıyken)
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        debugPrint('Bildirime tıklanarak açıldı: ${message.data}');
        _handleNotificationClick(message);
      });

      // App tamamen kapalıyken gelen bildirimi yakala
      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        _handleNotificationClick(initialMessage);
      }

      // Background mesajlar
      FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
    } catch (e) {
      debugPrint('Firebase başlatma hatası: $e');
    }
  }

  /// Kullanıcıdan izinleri iste
  static Future<void> _configureFcmPermissions() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    debugPrint('FCM izin durumu: ${settings.authorizationStatus}');
  }

  /// Local notification yapılandırması
  static Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/launcher_icon');
    const iosSettings = DarwinInitializationSettings();

    await _notificationsPlugin.initialize(
      const InitializationSettings(android: androidSettings, iOS: iosSettings),
    );
  }

  /// Firebase token al ve backend'e gönder
  static Future<void> _handleFirebaseToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    debugPrint('Firebase Token: $token');

    // TODO: token'ı backend'e kaydet (örnek endpoint)
    // await UserService.updateFirebaseToken(token);
  }

  /// Local bildirimi göster
  @pragma('vm:entry-point')
  static Future<void> _showLocalNotification(RemoteMessage message) async {
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

    const iosPlatform = DarwinNotificationDetails(
        presentAlert: true, presentSound: true, sound: "default");

    const platform =
        NotificationDetails(android: androidPlatform, iOS: iosPlatform);

    await _notificationsPlugin.show(
      message.messageId.hashCode,
      message.notification?.title ?? "",
      message.notification?.body ?? "",
      platform,
      payload: message.data.toString(),
    );
  }

  /// Arka planda gelen mesajları işle
  @pragma('vm:entry-point')
  static Future<void> _backgroundMessageHandler(RemoteMessage message) async {
    if (!_processedMessageIds.contains(message.messageId)) {
      debugPrint('Background mesaj alındı: ${message.messageId}');
      _processedMessageIds.add(message.messageId ?? '');
    }
  }

  /// Kullanıcı bildirime tıkladığında çalışır
  static void _handleNotificationClick(RemoteMessage message) {
    final data = message.data;
    debugPrint("Bildirim tıklama verisi: $data");

    // TODO: Uygulama içinde yönlendirme yapılabilir
    // örn: if (data['tip'] == 'ORDER') goToOrderDetail(data['referenceId']);
  }
}
