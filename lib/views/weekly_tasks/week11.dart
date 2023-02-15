import 'package:flutter/material.dart';
import 'package:training_app/utils/app_routes.dart';
import 'package:training_app/views/weekly_tasks/widgets/custombutton.dart';

class Week11 extends StatefulWidget {
  const Week11({Key? key}) : super(key: key);

  @override
  State<Week11> createState() => _Week11State();
}

class _Week11State extends State<Week11> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Week 11"),
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
                name: '42. Slivers',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().sliversScreen);
                }),
            customButton(
                name: '43. State Management',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().stateManagementScreen);
                }),
            customButton(
                name: '44. save files/get files from local',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().saveFileLocallyScreen);
                }),
            customButton(
                name: '45. Method Chanel',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().methodChanelScreen);
                }),
          ],
        ),
      ),
    );
  }
}
