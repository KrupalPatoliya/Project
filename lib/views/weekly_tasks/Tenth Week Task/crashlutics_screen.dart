import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class CrashlyticsScreen extends StatefulWidget {
  const CrashlyticsScreen({Key? key}) : super(key: key);

  @override
  State<CrashlyticsScreen> createState() => _CrashlyticsScreenState();
}

class _CrashlyticsScreenState extends State<CrashlyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Crashlytics"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          child: const Text("Crash App"),
          onPressed: () async {
            print("App Is Crashed");
            await FirebaseAnalytics.instance.logEvent(name: "Crash_Event", parameters: {"Crash_Event": "Crash"});
            FirebaseCrashlytics.instance.crash();
          },
        ),
      ),
    );
  }
}
