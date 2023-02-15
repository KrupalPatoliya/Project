import 'package:flutter/material.dart';

class IntroOfFlutter extends StatefulWidget {
  const IntroOfFlutter({Key? key}) : super(key: key);

  @override
  State<IntroOfFlutter> createState() => _IntroOfFlutterState();
}

class _IntroOfFlutterState extends State<IntroOfFlutter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text("Flutter Intro"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2, color: Colors.white)),
              child: const FlutterLogo(),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Flutter is an open-source UI software development kit created by Google. It is used to develop cross-platform applications for Android, iOS, Linux, macOS, Windows, Google Fuchsia,and the web from a single codebase.",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '"The first version of Flutter was known as "SKY" and ran on the Android operating system"',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
