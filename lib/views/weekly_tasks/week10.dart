import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:training_app/utils/app_routes.dart';
import 'package:training_app/views/weekly_tasks/widgets/custombutton.dart';

class Week10 extends StatefulWidget {
  const Week10({Key? key}) : super(key: key);

  @override
  State<Week10> createState() => _Week10State();
}

class _Week10State extends State<Week10> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Week 10"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            customButton(
                name: '36. Analytics',
                tap: () async {
                  await FirebaseAnalytics.instance.logEvent(name: "Analytics_Page_Open", parameters: {"Analytics_event": "true"}).then((value) {
                    print("Log");
                    Navigator.of(context).pushNamed(AppRoutes().analyticsScreen);
                  }).onError((error, stackTrace) {
                    print(error);
                  });
                }),
            customButton(
                name: '37. Crashlytics',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().crashlyticsScreen);
                }),
            customButton(
                name: '38. Dynamic Links',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().dynamicLinksScreen);
                }),
            customButton(
                name: '39. Notification',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().notificationScreen);
                }),
          ],
        ),
      ),
    );
  }
}
