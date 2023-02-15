import 'package:flutter/material.dart';
import 'package:training_app/utils/app_routes.dart';
import 'package:training_app/views/weekly_tasks/widgets/custombutton.dart';
import 'package:url_launcher/url_launcher.dart';

class Week1 extends StatefulWidget {
  const Week1({Key? key}) : super(key: key);

  @override
  State<Week1> createState() => _Week1State();
}

class _Week1State extends State<Week1> {
  final Uri _url = Uri.parse('https://docs.flutter.dev/get-started/install');
  final Uri _url1 = Uri.parse('https://docs.flutter.dev/testing/debugging');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  Future<void> _launchUrl1() async {
    if (!await launchUrl(_url1)) {
      throw 'Could not launch $_url1';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text("Week 1"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            customButton(
              name: '1. What is Flutter',
              tap: () {
                Navigator.of(context).pushNamed(AppRoutes().introOfFlutter);
              },
            ),
            customButton(
              name: '2. Install Flutter',
              tap: _launchUrl,
              // tap: () {
              //   Navigator.of(context).pushNamed('installFlutter');
              // },
            ),
            customButton(
              name: '4. Dart Programming',
              tap: () {
                Navigator.of(context).pushNamed(AppRoutes().dartProgramming);
              },
            ),
            customButton(name: '5. Debugging app', tap: _launchUrl1),
            customButton(
                name: '6. Life cycle/activity',
                tap: () {
                  Navigator.of(context).pushNamed(AppRoutes().installFlutter);
                }),
            customButton(
                name: '7. Navigation',
                tap: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes().firstNavigationScreen);
                }),
          ],
        ),
      ),
    );
  }
}
