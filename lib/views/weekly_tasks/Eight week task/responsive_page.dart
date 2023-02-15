import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_app/utils/app_routes.dart';
import 'package:training_app/views/weekly_tasks/widgets/custombutton.dart';

class ResponsivePage extends StatefulWidget {
  const ResponsivePage({Key? key}) : super(key: key);

  @override
  State<ResponsivePage> createState() => _ResponsivePageState();
}

class _ResponsivePageState extends State<ResponsivePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Responsive Page"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            customButton(
                name: 'Orientation Page',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().orientationScreen);
                }),
            customButton(
                name: 'Universal apps',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().universalScreen);
                }),
          ],
        ),
      ),
    );
  }
}
