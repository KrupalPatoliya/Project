import 'package:flutter/material.dart';
import 'package:training_app/utils/app_routes.dart';
import 'package:training_app/views/weekly_tasks/widgets/custombutton.dart';

class Week6 extends StatefulWidget {
  const Week6({Key? key}) : super(key: key);

  @override
  State<Week6> createState() => _Week6State();
}

class _Week6State extends State<Week6> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Week 6"),
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
                name: '20. Share with Social',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().sharingScreen);
                }),
            customButton(
                name: '21. share with default intent',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().socialSharingScreen);
                }),
            // customButton(
            //     name: '21. Share with default intent',
            //     tap: () {
            //       Navigator.of(context).pushNamed(AppRoutes().shareDefaultIntentScreen);
            //     }),
            customButton(
                name: '22. Admob Ads',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().adMobsScreen);
                }),
            customButton(
                name: '22. Facebook Ads',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().faceBookAdsScreen);
                }),
          ],
        ),
      ),
    );
  }
}
