import 'package:flutter/material.dart';
import 'package:training_app/views/weekly_tasks/First%20week%20tasks/Navigation/second_screen.dart';

class ForthNavigationScreen extends StatefulWidget {
  const ForthNavigationScreen({Key? key}) : super(key: key);

  @override
  State<ForthNavigationScreen> createState() => _ForthNavigationScreenState();
}

class _ForthNavigationScreenState extends State<ForthNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text("Navigation 4 Page"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "4th page is now on 2nd page stack",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context)
                        .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const SecondNavigationScreen()), (route) => false);
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "page 2 push and remove until",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
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
