import 'package:flutter/material.dart';

class ThirdNavigationScreen extends StatefulWidget {
  const ThirdNavigationScreen({Key? key}) : super(key: key);

  @override
  State<ThirdNavigationScreen> createState() => _ThirdNavigationScreenState();
}

class _ThirdNavigationScreenState extends State<ThirdNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text("Navigation 3 Page"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(38.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "pop",
                style: TextStyle(fontSize: 30),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "page 2",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "popUntil",
                style: TextStyle(fontSize: 30),
              ),
              ElevatedButton(
                onPressed: () {
                  int count = 0;
                  Navigator.popUntil(context, (route) {
                    return count++ == 2;
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "pop until to page 1 ",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
