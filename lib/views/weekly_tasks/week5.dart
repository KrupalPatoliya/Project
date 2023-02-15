import 'package:flutter/material.dart';
import 'package:training_app/views/weekly_tasks/widgets/custombutton.dart';

import '../../utils/app_routes.dart';

class Week5 extends StatefulWidget {
  const Week5({Key? key}) : super(key: key);

  @override
  State<Week5> createState() => _Week5State();
}

class _Week5State extends State<Week5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Week 5"),
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
                name: '18. Audio Player',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().audioPlayerScreen);
                }),
            customButton(
                name: '18. Video Player',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().videoPlayerScreen);
                }),
            customButton(
                name: '19. Social Media Login',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().socialMediaLogInScreen);
                }),
          ],
        ),
      ),
    );
  }
}
