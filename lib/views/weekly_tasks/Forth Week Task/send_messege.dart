import 'package:flutter/material.dart';
import 'package:training_app/utils/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/custombutton.dart';

class SendMessege extends StatefulWidget {
  const SendMessege({Key? key}) : super(key: key);

  @override
  State<SendMessege> createState() => _SendMessegeState();
}

class _SendMessegeState extends State<SendMessege> {
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
                name: 'Send SMS',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().sendSMSScreen);
                }),
            customButton(
                name: 'Send Email',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().sendMessagesScreen);
                }),
            customButton(
                name: 'Send call',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().sendCallScreen);
                }),
          ],
        ),
      ),
    );
  }
}
