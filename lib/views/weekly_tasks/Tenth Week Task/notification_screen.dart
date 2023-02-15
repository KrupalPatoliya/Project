import 'package:flutter/material.dart';

import '../../../helpers/notification/local_notification_helpper.dart';
import '../widgets/custombutton.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocalNotificationHelper.localNotificationHelper.initNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Notification"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            customButton(
              tap: () {
                LocalNotificationHelper.localNotificationHelper.showSimpleNotification();
              },
              name: "Simple Notification",
            ),
            customButton(
              tap: () {
                LocalNotificationHelper.localNotificationHelper.showBigPictureNotification();
              },
              name: "Big Picture Notification",
            ),
            customButton(
              tap: () {
                LocalNotificationHelper.localNotificationHelper.showProgressNotification();
              },
              name: "Progress Notification",
            ),
            customButton(
              tap: () {
                LocalNotificationHelper.localNotificationHelper.showPeriodicNotification();
              },
              name: "Periodic Notification",
            ),
            customButton(
              tap: () {
                LocalNotificationHelper.localNotificationHelper.showScheduleNotification();
              },
              name: "Schedule Notification",
            ),
          ],
        ),
      ),
    );
  }
}
