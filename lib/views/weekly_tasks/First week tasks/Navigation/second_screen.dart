import 'package:flutter/material.dart';
import 'package:training_app/views/weekly_tasks/First%20week%20tasks/Navigation/Third_screen.dart';
import 'package:training_app/views/weekly_tasks/First%20week%20tasks/Navigation/first_screen.dart';
import 'package:training_app/views/weekly_tasks/First%20week%20tasks/Navigation/forth_screen.dart';


class SecondNavigationScreen extends StatefulWidget {
  const SecondNavigationScreen({Key? key}) : super(key: key);

  @override
  State<SecondNavigationScreen> createState() => _SecondNavigationScreenState();
}

class _SecondNavigationScreenState extends State<SecondNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text("Navigation 2 Page"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "pop",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(builder: (context) => const FirstNavigationScreen()),
                    );
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "page 1",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "push",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ThirdNavigationScreen()),
                    );
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "page 3",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "push Replacement",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForthNavigationScreen(),
                        ),
                      );
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "page 4 push-replacement",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
