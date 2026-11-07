import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('111', 'channelName', 'channelDescription',
        sound: RawResourceAndroidNotificationSound('exercise_notifications'),
        importance: Importance.max, priority: Priority.max, playSound: true);
const IOSNotificationDetails iOSPlatformChannelSpecifics =
    IOSNotificationDetails(
  presentAlert: true,
  // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
  presentBadge: true,
  // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
  presentSound: true,
  // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
  sound: '',
  // Specifics the file path to play (only from iOS 10 onwards)
  badgeNumber: 2,
  // The application's icon badge number
  attachments: null,
  // (only from iOS 10 onwards)
  subtitle: 'Oi gioi oi',
  //Secondary description  (only from iOS 10 onwards)
  threadIdentifier: 'nulll', //  (only from iOS 10 onwards)
);
const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

class NotificationsManager {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationsManager.init(){
    if (Platform.isIOS) {
      requestIOSPermissions();
    }
    initializationSettings();
  }
  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()!
        .requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> initializationSettings() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    // có thể là dẫn tới ứng dụng
  }

  Future<void> showNotificationOneTime(int hour, int minute) async {
    tz.initializeTimeZones();
    String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
    print(timeZoneName);

    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local,
        tz.TZDateTime.now(tz.local).year,
        tz.TZDateTime.now(tz.local).month,
        tz.TZDateTime.now(tz.local).day,
        hour,
        minute);
    if (scheduledDate.isBefore(tz.TZDateTime.now(tz.local))) {
      scheduledDate = scheduledDate.add(const Duration(hours: 0, minutes: 2));
    }
    var platformChannel = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        'Thông báo luyện tập hàng ngày',
        'Đã đến lúc bạn tập luyện!',
        // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        scheduledDate,
        platformChannel,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
    await showRepeatedNotification();
  }

  Future<void> showRepeatedNotification() async {
    var platformChannel = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    // để test thì chỉnh sang everyMinute
    await flutterLocalNotificationsPlugin.periodicallyShow(DateTime.now().minute, 'Đã đến giờ rồi',
        'Tiếp tục nhấc mông lên đi!', RepeatInterval.daily, platformChannel,
        payload: 'New Payload');
  }

  Future<void> showNotification() async {
    await flutterLocalNotificationsPlugin.show(123, 'Đến giờ rồi',
        'Tập đi!', platformChannelSpecifics,
        payload: 'data');
  }
}
void cancelAllNotification(){
  NotificationsManager.init().flutterLocalNotificationsPlugin.cancelAll();
}