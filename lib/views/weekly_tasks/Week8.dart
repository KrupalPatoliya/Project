import 'package:flutter/material.dart';
import 'package:training_app/views/weekly_tasks/widgets/custombutton.dart';

import '../../utils/app_routes.dart';

class Week8 extends StatefulWidget {
  const Week8({Key? key}) : super(key: key);

  @override
  State<Week8> createState() => _Week8State();
}

class _Week8State extends State<Week8> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Week 8"),
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
                name: '27. Animations/Material UI',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().animationScreen);
                }),
            customButton(
                name: '28. Responsive apps',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().responsiveScreen);
                }),
            customButton(
                name: '29. localization',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().localizationScreen);
                }),
            customButton(
                name: '30. Action-sheet & popover controller',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().actionSheetScreen);
                }),
          ],
        ),
      ),
    );
  }
}
