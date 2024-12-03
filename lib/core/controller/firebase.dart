import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rencber_mobile/firebase_options.dart';

class FirebaseInit {
  static void initFcm() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    await FirebaseMessaging.instance.requestPermission(alert: true, badge: true, provisional: false, sound: true);
    //await saveDeviceToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await onMessageForeground(message);
    });

    FirebaseMessaging.onBackgroundMessage(backgroundNotification);
  }

  static Future<void> onMessageForeground(RemoteMessage message) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = const AndroidInitializationSettings("@mipmap/ic_launcher");
    var ios = const DarwinInitializationSettings();
    await flutterLocalNotificationsPlugin.initialize(InitializationSettings(android: android, iOS: ios));
    var androidPlatform = const AndroidNotificationDetails('rencber_mobile', 'rencber_mobile_channel', importance: Importance.high, priority: Priority.high);
    var iosPlatform = const DarwinNotificationDetails(presentAlert: true, presentSound: true, sound: "default");
    var platform = NotificationDetails(android: androidPlatform, iOS: iosPlatform);
    await flutterLocalNotificationsPlugin.show(message.messageId.hashCode, message.notification?.title ?? "", message.notification?.body ?? "", platform);
  }

  @pragma('vm:entry-point')
  static Future<void> backgroundNotification(RemoteMessage message) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = const AndroidInitializationSettings("@mipmap/ic_launcher");
    var ios = const DarwinInitializationSettings();
    await flutterLocalNotificationsPlugin.initialize(InitializationSettings(android: android, iOS: ios));
    var androidPlatform = const AndroidNotificationDetails('rencber_mobile', 'rencber_mobile_channel', importance: Importance.high, priority: Priority.high);
    var iosPlatform = const DarwinNotificationDetails(presentAlert: true, presentSound: true, sound: "default");
    var platform = NotificationDetails(android: androidPlatform, iOS: iosPlatform);
    await flutterLocalNotificationsPlugin.show(message.messageId.hashCode, message.notification?.title ?? "", message.notification?.body ?? "", platform);
  }

  // static Future<void> saveDeviceToken() async {
  //   await Future.delayed(const Duration(seconds: 1));
  //   var fcmToken = Platform.isAndroid ? await FirebaseMessaging.instance.getToken() : await FirebaseMessaging.instance.getAPNSToken();
  //   var deviceId = await FlutterUdid.udid;
  //   var platform = Platform.isAndroid ? "android" : "ios";
  //   await SecureStorage.instance.writeSecureData("fcmToken", fcmToken ?? "");
  //   await SecureStorage.instance.writeSecureData("deviceId", deviceId);
  //   await NotificationService.instance.postNotificationInfo(fcmToken ?? "", deviceId, platform);

  //   // var isFcmToken = await SecureStorage.instance.readSecureData("fcmToken");
  //   // if (isFcmToken.ext.isNullOrEmpty) {
  //   //   await Future.delayed(const Duration(seconds: 1));
  //   //   var fcmToken = Platform.isAndroid ? await FirebaseMessaging.instance.getToken() : await FirebaseMessaging.instance.getAPNSToken();
  //   //   var deviceId = await FlutterUdid.udid;
  //   //   var platform = Platform.isAndroid ? "android" : "ios";
  //   //   await SecureStorage.instance.writeSecureData("fcmToken", fcmToken ?? "");
  //   //   await SecureStorage.instance.writeSecureData("deviceId", deviceId);
  //   //   await NotificationService.instance.postNotificationInfo(fcmToken ?? "", deviceId, platform);
  //   // } else {
  //   //   return;
  //   // }
  // }
}
