import 'package:flutter/material.dart';

import '../../utils/app_routes.dart';
import 'widgets/custombutton.dart';

class Week3 extends StatefulWidget {
  const Week3({Key? key}) : super(key: key);

  @override
  State<Week3> createState() => _Week3State();
}

class _Week3State extends State<Week3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Week 3"),
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
                name: '12. Gestures',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().gesturesScreen);
                }),
            customButton(
                name: 'Drag And Drop',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().draggableScreen);
                }),
            customButton(
                name: 'Image Picker',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().imagePickerScreen);
                }),
            customButton(
                name: '13. sqlite db',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().sqLiteDBScreen);
                }),
            customButton(
                name: '14. API Calling',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().apiCallingScreen);
                }),
          ],
        ),
      ),
    );
  }
}
