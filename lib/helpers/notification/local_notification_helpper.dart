import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;

class LocalNotificationHelper {
  LocalNotificationHelper._();

  static final LocalNotificationHelper localNotificationHelper = LocalNotificationHelper._();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  initNotification() {
    var initializationSettingsAndroid = const AndroidInitializationSettings('app_icon');
    var initializationSettingsIOs = const DarwinInitializationSettings();
    var initSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: ((val) {}),
    );
  }

  showSimpleNotification() async {
    var androidDetails = const AndroidNotificationDetails(
      'id',
      'channel',
      channelDescription: 'description',
      priority: Priority.high,
      importance: Importance.max,
    );
    var iOSDetails = const DarwinNotificationDetails();
    var platformDetails = NotificationDetails(android: androidDetails, iOS: iOSDetails);
    await flutterLocalNotificationsPlugin.show(0, 'Flutter Local Notification', "Simple Notification", platformDetails,
        payload: 'Simple Notification');
  }

  Future<void> showScheduleNotification() async {
    var scheduledNotificationDateTime = DateTime.now().add(const Duration(seconds: 5));
    var androidDetails = const AndroidNotificationDetails(
      'channel_id',
      'Channel Name',
      channelDescription: "Channel Description",
      icon: 'app_icon',
      largeIcon: DrawableResourceAndroidBitmap("app_icon"),
      priority: Priority.high,
      importance: Importance.max,
    );
    var iOSDetails = const DarwinNotificationDetails();
    var platformDetails = NotificationDetails(android: androidDetails, iOS: iOSDetails);
    // await flutterLocalNotificationsPlugin.zonedSchedule(
    //   0,
    //   "Flutter Local Notification",
    //   "Schedule Notification",
    //   tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
    //   androidAllowWhileIdle: true,
    //   platformDetails,
    //   uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    //   payload: "Schedule Notification",
    // );

    await flutterLocalNotificationsPlugin.schedule(
      0,
      "Flutter Local Notification",
      "Schedule Notification",
      scheduledNotificationDateTime,
      platformDetails,
    );
  }

  Future<void> showProgressNotification() async {
    const int maxProgress = 5;
    for (int i = 0; i <= maxProgress; i++) {
      await Future<void>.delayed(const Duration(seconds: 1), () async {
        final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('‘channel_id’', '‘Channel Name’',
            channelDescription: '‘Channel Description’',
            channelShowBadge: false,
            importance: Importance.max,
            priority: Priority.high,
            onlyAlertOnce: true,
            showProgress: true,
            maxProgress: maxProgress,
            progress: i);
        final NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
        await flutterLocalNotificationsPlugin.show(0, "Flutter Local Notification", "Progress Notification", notificationDetails,
            payload: "ProgressNotification");
      });
    }
  }

  Future<void> showPeriodicNotification() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      "channel_id",
      "Channel Name",
      channelDescription: "Channel Description",
      priority: Priority.high,
      importance: Importance.max,
    );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      "Flutter Local Notification",
      "Periodic Notification",
      RepeatInterval.everyMinute,
      notificationDetails,
      payload: "Periodic Notification",
    );
  }

  Future<void> showBigPictureNotification() async {
    var bigPictureStyleInformation = const BigPictureStyleInformation(
      DrawableResourceAndroidBitmap("app_icon"),
      largeIcon: DrawableResourceAndroidBitmap("app_icon"),
      contentTitle: "Flutter Big Picture Notification Title",
      summaryText: "Flutter Big Picture Notification Summary Text",
    );
    var androidDetails = AndroidNotificationDetails(
      "channel_id",
      "Channel Name",
      channelDescription: "Channel Description",
      styleInformation: bigPictureStyleInformation,
      priority: Priority.high,
      importance: Importance.max,
    );
    var platformDetails = NotificationDetails(
      android: androidDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      "Flutter Local Notification",
      "Big Picture Notification",
      platformDetails,
      payload: "Big Picture Notification",
    );
  }
}
