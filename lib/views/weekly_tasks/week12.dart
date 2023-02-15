import 'package:flutter/material.dart';
import 'package:training_app/utils/app_routes.dart';
import 'package:training_app/views/weekly_tasks/widgets/custombutton.dart';

class Week12 extends StatefulWidget {
  const Week12({Key? key}) : super(key: key);

  @override
  State<Week12> createState() => _Week12State();
}

class _Week12State extends State<Week12> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Week 12"),
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
                name: 'Bloc',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().blocManagementScreen);
                }),
            customButton(
                name: 'Api Calling Bloc',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().blocApiScreen);
                }),
            customButton(
                name: 'Redux',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().reduxManagementScreen);
                }),
            customButton(
                name: 'Provider',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().providerManagementScreen);
                }),
          ],
        ),
      ),
    );
  }
}
