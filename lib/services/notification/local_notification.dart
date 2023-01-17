import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taskjob_aliapp/view/calender_screen.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotification {
  // bool initCheck = false;
  static final _notfication = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();
  _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channel id', 'channel name',
          // 'channel description',
          channelDescription: 'channel description',
          importance: Importance.max),
    );
  }

// await flutterLocalNotificationsPlugin.zonedSchedule(
//     0,
//     'scheduled title',
//     'scheduled body',
//     tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
//     const NotificationDetails(
//         android: AndroidNotificationDetails(
//             'your channel id', 'your channel name',
//             channelDescription: 'your channel description')),
//     androidAllowWhileIdle: true,
//     uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime);
  int id = 0;

  Future<void> _showProgressNotification() async {
    id++;
    final int progressId = id;
    const int maxProgress = 5;
    for (int i = 0; i <= maxProgress; i++) {
      if (i == maxProgress) {
        print('It Worked');
      }
      await Future<void>.delayed(const Duration(seconds: 1), () async {
        final AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails('progress channel', 'progress channel',
                channelDescription: 'progress channel description',
                channelShowBadge: false,
                importance: Importance.max,
                priority: Priority.high,
                onlyAlertOnce: true,
                showProgress: true,
                maxProgress: maxProgress,
                progress: i);
        final NotificationDetails notificationDetails =
            NotificationDetails(android: androidNotificationDetails);
        await _notfication.show(progressId, 'progress notification title',
            'progress notification body', notificationDetails,
            payload: 'item x');
      });
    }
  }

  // DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
  Future _notfiactionDetialesAndroid(int maxProgress, int i) async {
    return NotificationDetails(
        android: AndroidNotificationDetails(
            'progress channel', 'progress channel',
            channelDescription: 'progress channel description',
            channelShowBadge: false,
            importance: Importance.max,
            priority: Priority.high,
            onlyAlertOnce: true,
            showProgress: true,
            maxProgress: maxProgress,
            progress: i));
  }

  Future<void> showProgressNotificationScheduled({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required int schedlueDate,
    required int minut,
  }) async {
    const int maxProgress = 5;
    for (int i = 0; i <= maxProgress; i++) {
      if (i == maxProgress) {
        print('It Worked');
      }
      await Future<void>.delayed(const Duration(seconds: 1), () async {
        // final NotificationDetails notificationDetails =
        //     NotificationDetails(android: androidNotificationDetails);
        await _notfication.zonedSchedule(
          id,
          title,
          body,
          _scheduleDaily(Time(schedlueDate, minut)),
          await _notfiactionDetialesAndroid(maxProgress, i),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true,
          payload: payload,
          matchDateTimeComponents: DateTimeComponents.time,
        );
      });
    }
  }
  // DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD

  void showScheduleNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required int schedlueDate,
    required int minut,
  }) async {
    print('Have called the Notification');
    _notfication.zonedSchedule(
        id,
        title,
        body,
        // tz.TZDateTime.from(schedlueDate, tz.local)
        _scheduleDaily(Time(schedlueDate, minut)),
        await _notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime _scheduleDaily(Time time) {
    print('Have called the Notification SCHEDULE 8');
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    print('Have called the Notification SCHEDULE ${time.hour} ${time.minute}');
    // var dateNow = DateTime.now();
    // if (scheduledDate.hour ==
    //     DateTime(dateNow.year, dateNow.month, dateNow.day, 8)){}
    return scheduledDate;
    // .isBefore(now)
    //     ? scheduledDate.add(const Duration(days: 1))
    //     : scheduledDate;
  }

  static Future<void> init(
      {bool initSchedlue = true, required BuildContext context}) async {
    if (initSchedlue) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
      print('AAAAAAAAAAAAAAAAA init');
    }
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    const settings = InitializationSettings(iOS: ios, android: android);
    await _notfication.initialize(
      settings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        final String? payload = notificationResponse.payload;
        if (notificationResponse.payload != null) {
          debugPrint('notification payload: $payload');
        }
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CalenderScreen()),
        );
      },
      //  onDidReceiveBackgroundNotificationResponse:
      //     (NotificationResponse notificationResponse) async {
      //   print('It Works with the Notification DDDDDDDDDDDDDDDDD');
      // }
    );
    // if (initSchedlue) {
    // initCheck = true;
    print('AAAAAAAAAAAAAAAAA init 2');

    // }
  }
}
