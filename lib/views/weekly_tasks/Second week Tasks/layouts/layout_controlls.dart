import 'package:flutter/material.dart';

import '../../../../utils/app_routes.dart';
import '../../widgets/custombutton.dart';

class LayOutScreen extends StatefulWidget {
  const LayOutScreen({Key? key}) : super(key: key);

  @override
  State<LayOutScreen> createState() => _LayOutScreenState();
}

class _LayOutScreenState extends State<LayOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("layouts/controls"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            customButton(name: 'Drawer', tap: () {
              Navigator.of(context).pushNamed(AppRoutes().drawerScreen);
            }),
            customButton(name: 'Tab Bar', tap: () {
              Navigator.of(context).pushNamed(AppRoutes().tabBarScreen);
            }),
            customButton(name: 'Bottom Navigation Bar', tap: () {
              Navigator.of(context).pushNamed(AppRoutes().bottomNavigationScreen);
            }),
            customButton(name: 'Food Delivery App', tap: () {
              Navigator.of(context).pushNamed(AppRoutes().foodAppHomePageScreen);
            }),
          ],
        ),
      ),
    );
  }
}
