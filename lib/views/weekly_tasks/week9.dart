import 'package:flutter/material.dart';
import 'package:training_app/views/weekly_tasks/widgets/custombutton.dart';

import '../../utils/app_routes.dart';

class Week9 extends StatefulWidget {
  const Week9({Key? key}) : super(key: key);

  @override
  State<Week9> createState() => _Week9State();
}

class _Week9State extends State<Week9> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Week 9"),
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
                name: '32. Authentication',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().authenticationScreen);
                }),
            customButton(
                name: '33. Realtime database',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().realTimeDatabaseScreen);
                }),
            customButton(
                name: '34. Firestore database',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().fireStoreDatabaseScreen);
                }),
          ],
        ),
      ),
    );
  }
}
