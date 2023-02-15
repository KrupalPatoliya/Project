import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import '../widgets/custombutton.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Analytics"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            customButton(
              name: 'Log Event',
              tap: () async {
                // print("Log");
                await FirebaseAnalytics.instance.logEvent(name: "Test_Event", parameters: {"Event_Testing": "Test"}).then((value) {
                  print("Log");
                }).onError((error, stackTrace) {
                  print(error);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
