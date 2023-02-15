import 'package:flutter/material.dart';

class StackPage extends StatefulWidget {
  const StackPage({Key? key}) : super(key: key);

  @override
  State<StackPage> createState() => _StackPageState();
}

class _StackPageState extends State<StackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text("Stack"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 300,
              width: 300,
              color: Colors.blue,
            ),
            Container(
              alignment: Alignment.center,
              height: 250,
              width: 250,
              color: Colors.red,
            ),
            Container(
              alignment: Alignment.center,
              height: 200,
              width: 200,
              color: Colors.blue,
            ),
            Container(
              alignment: Alignment.center,
              height: 150,
              width: 150,
              color: Colors.red,
            ),
            Container(
              alignment: Alignment.center,
              height: 100,
              width: 100,
              color: Colors.blue,
            ),
            const Text(
              "Using Stack",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
