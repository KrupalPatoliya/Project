import 'package:flutter/material.dart';

import '../../utils/app_routes.dart';
import 'widgets/custombutton.dart';

class Week2 extends StatefulWidget {
  const Week2({Key? key}) : super(key: key);

  @override
  State<Week2> createState() => _Week2State();
}

class _Week2State extends State<Week2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Week 2"),
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
                name: '8.Pass data between view controllers',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().addDataScreen);
                }),
            customButton(
                name: '9. Widgets',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().allWidgetsScreen);
                }),
            customButton(
                name: '10. layouts/controls',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().layoutsScreen);
                }),
            customButton(
                name: '11. custom controls properties',
                tap: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes().customControlsScreen);
                }),
          ],
        ),
      ),
    );
  }
}
