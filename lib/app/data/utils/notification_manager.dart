import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  NotificationManager._();

  static Future initNotifications() async {
    await initPushNotifications();
    await initLocalNotifications();
  }

  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static final localNotifications = FlutterLocalNotificationsPlugin();

  static const androidChannel = AndroidNotificationChannel(
    'important_channel',
    'Important Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
  );

  static Future<void> configureFirebaseMessaging() async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        print("Received a notification while the app is in the foreground!");
        // Handle foreground notification here
      },
    );

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        print("User tapped on the notification in the background!");
        // Handle background notification here
      },
    );
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    // Handle background message here
  }

  static handleMessage(RemoteMessage? message) {
    if (message == null) return;
  }

  static Future handleBackgroundMessage(RemoteMessage? message) async {
    if (message == null) return;
  }

  static Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then((handleMessage));
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen(
      (message) {
        final notification = message.notification;
        if (notification == null) return;
        localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
                androidChannel.id, androidChannel.name,
                channelDescription: androidChannel.description,
                icon: '@drawable/ic_launcher'),
          ),
          payload: jsonEncode(
            message.toMap(),
          ),
        );
      },
    );
  }

  static Future<void> initLocalNotifications() async {
    final iOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (
          id,
          title,
          body,
          payload,
        ) {});
    const android = AndroidInitializationSettings(
      '@drawable/ic_launcher',
    );

    final settings = InitializationSettings(
      android: android,
      iOS: iOS,
    );
    await localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        final message = RemoteMessage.fromMap(
          jsonDecode(
            '${payload.payload}',
          ),
        );
        handleMessage(message);
      },
    );

    final platform = localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(androidChannel);
  }
}
