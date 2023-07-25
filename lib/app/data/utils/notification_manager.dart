import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_outdoor_footprint/app/data/utils/widget_manager.dart';

class NotificationManager {
  NotificationManager._();

  static Future initNotifications() async {
    await initLocalNotifications();
    await initPushNotifications();
  }

  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static final localNotifications = FlutterLocalNotificationsPlugin();

  static const androidChannel = AndroidNotificationChannel(
    'important_channel',
    'Important Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.high,
    playSound: true,
  );

  static Future<void> configureFirebaseMessaging() async {
    FirebaseMessaging.onMessage.listen(
      (message) {
        final notification = message.notification;
        if (notification == null) return;
        // localNotifications.show(
        //   notification.hashCode,
        //   notification.title,
        //   notification.body,
        //   NotificationDetails(
        //     android: AndroidNotificationDetails(
        //       androidChannel.id,
        //       androidChannel.name,
        //       channelDescription: androidChannel.description,
        //       icon: '@drawable/ic_launcher',
        //       visibility: NotificationVisibility.public,
        //       category: AndroidNotificationCategory.message,
        //     ),
        //   ),
        //   payload: jsonEncode(
        //     message.toMap(),
        //   ),
        // );
        if (Platform.isAndroid) {
          WidgetManager.customSnackBar(
            title: '${notification.title}',
            body: '${notification.body}',
            type: SnackBarType.notification,
          );
        }
      },
    );

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        final notification = message.notification;
        if (notification == null) return;
        localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              androidChannel.id,
              androidChannel.name,
              channelDescription: androidChannel.description,
              icon: '@drawable/ic_launcher',
              visibility: NotificationVisibility.public,
              category: AndroidNotificationCategory.message,
            ),
          ),
          payload: jsonEncode(
            message.toMap(),
          ),
        );
      },
    );
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;
    localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidChannel.id,
          androidChannel.name,
          channelDescription: androidChannel.description,
          icon: '@drawable/ic_launcher',
        ),
      ),
      payload: jsonEncode(
        message.toMap(),
      ),
    );
  }

  static void showForegroundNotification(String title, String body) {
    // Use flutter_local_notifications to show custom UI for foreground notifications
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'important_channel', // Change to a unique channel ID for foreground notifications
      'Foreground Notifications', // Change to a channel name for foreground notifications
      channelDescription: 'This channel is used for foreground notifications',
      importance: Importance.high,
      playSound: true,
      icon: '@drawable/ic_launcher',
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    // Show the notification using flutter_local_notifications plugin
    localNotifications.show(
      0, // Change to a unique notification ID
      title,
      body,
      notificationDetails,
    );
  }

  static handleMessage(RemoteMessage? message) {
    if (message == null) return;
    final notification = message.notification;
    if (notification == null) return;
    localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidChannel.id,
          androidChannel.name,
          channelDescription: androidChannel.description,
          icon: '@drawable/ic_launcher',
        ),
      ),
      payload: jsonEncode(
        message.toMap(),
      ),
    );
  }

  static Future handleBackgroundMessage(RemoteMessage? message) async {
    if (message == null) return;
    final notification = message.notification;
    if (notification == null) return;
    localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidChannel.id,
          androidChannel.name,
          channelDescription: androidChannel.description,
          icon: '@drawable/ic_launcher',
        ),
      ),
      payload: jsonEncode(
        message.toMap(),
      ),
    );
  }

  static Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then((handleMessage));
    await configureFirebaseMessaging();
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
