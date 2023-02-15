import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Drawer"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      drawer: Drawer(
        // backgroundColor: Colors.blue.shade50,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Welcome",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 3,
                color: Colors.blue,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.account_box,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "About",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 3,
                color: Colors.blue,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.settings,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 3,
                color: Colors.blue,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.login_rounded,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Log Out",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 3,
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: const Text(
          "Hello",
          style: TextStyle(
            fontSize: 24,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
