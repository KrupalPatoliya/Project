import 'package:flutter/material.dart';
import '../../utils/app_routes.dart';
import 'widgets/custombutton.dart';

class Week4 extends StatefulWidget {
  const Week4({Key? key}) : super(key: key);

  @override
  State<Week4> createState() => _Week4State();
}

class _Week4State extends State<Week4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Week 4"),
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
                name: '15. lazy loading',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().lazyLoadingScreen);
                }),
            customButton(
                name: '16. Map Integration',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().mapIntegrationScreen);
                }),
            customButton(
                name: '17. Send sms/Email/call',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().sendCallSMSEmailScreen);
                }),
          ],
        ),
      ),
    );
  }
}
