import 'package:flutter/material.dart';

class DartProgramming extends StatefulWidget {
  const DartProgramming({Key? key}) : super(key: key);

  @override
  State<DartProgramming> createState() => _DartProgrammingState();
}

class _DartProgrammingState extends State<DartProgramming> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text("Dart Programming"),
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-wO2czMjIwBf5ZLGS-6sPnIKFmxOXn8lIpA&usqp=CAU',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Dart is an open-source, general purpose, object-oriented language with c style syntax developed by google in 2011.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Dart Latest Version :- 2.18.5",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
