import 'package:flutter/material.dart';
import 'package:training_app/utils/app_routes.dart';
import 'package:training_app/views/weekly_tasks/widgets/custombutton.dart';

class Week7 extends StatefulWidget {
  const Week7({Key? key}) : super(key: key);

  @override
  State<Week7> createState() => _Week7State();
}

class _Week7State extends State<Week7> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Week 7"),
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
                name: '23. Custom camera and video',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().cameraScreen);
                }),
            customButton(
                name: '23. Custom Gallery',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().builtInCameraScreen);
                }),
            customButton(
                name: '23. In-Built Camera and Gallery',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().defaultCameraScreen);
                }),
            customButton(
                name: '24. pull to refresh',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().pullToRefreshScreen);
                }),
            customButton(
                name: '25. In app purchase',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().inAppPurchaseScreen);
                }),
            customButton(
                name: '26. Payment gateways',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().paymentGateWayScreen);
                }),
            // customButton(
            //     name: '26. Payment gateways Using Stripe',
            //     tap: () {
            //       Navigator.of(context).pushNamed(AppRoutes().paymentGateWayStripeScreen);
            //     }),
          ],
        ),
      ),
    );
  }
}
