import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:training_app/utils/app_routes.dart';
import 'package:training_app/views/homepage/homepage.dart';
import 'package:training_app/views/weekly_tasks/First%20week%20tasks/Navigation/Third_screen.dart';
import 'package:training_app/views/weekly_tasks/First%20week%20tasks/Navigation/second_screen.dart';
import 'package:training_app/views/weekly_tasks/widgets/custombutton.dart';

class FirstNavigationScreen extends StatefulWidget {
  const FirstNavigationScreen({Key? key}) : super(key: key);

  @override
  State<FirstNavigationScreen> createState() => _FirstNavigationScreenState();
}

class _FirstNavigationScreenState extends State<FirstNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text("Navigation 1 Page"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "push",
                style: TextStyle(fontSize: 30,color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SecondNavigationScreen(),
                      ),
                    );
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
            ],
          ),
        ),
      ),
    );
  }
}
