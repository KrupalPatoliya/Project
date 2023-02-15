import 'package:flutter/material.dart';
import 'package:training_app/models/users_data.dart';

import '../../../../utils/app_routes.dart';

class ShowDataScreen extends StatefulWidget {
  const ShowDataScreen({Key? key}) : super(key: key);

  @override
  State<ShowDataScreen> createState() => _ShowDataScreenState();
}

class _ShowDataScreenState extends State<ShowDataScreen> {
  @override
  Widget build(BuildContext context) {
    final users = ModalRoute.of(context)!.settings.arguments as Users;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Pass data"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Edit"))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border(
                  top: BorderSide(color: Colors.blue.shade900, width: 3),
                  right: BorderSide(color: Colors.blue.shade900, width: 3),
                  bottom: BorderSide(color: Colors.blue.shade900, width: 3),
                  left: BorderSide(color: Colors.blue.shade900, width: 3),
                ),
              ),
              child: Image.file(users.image),
            ),
            const SizedBox(
              height: 20,
            ),
            Material(
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                side: BorderSide(color: Colors.blue, width: 1.5),
              ),
              color: Colors.blue.shade700,
              child: Container(
                height: 70,
                width: 500,
                alignment: Alignment.center,
                child: Text(
                  "Name :- ${users.name}",
                  style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Material(
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                side: BorderSide(color: Colors.blue, width: 1.5),
              ),
              color: Colors.blue.shade700,
              child: Container(
                height: 70,
                width: 500,
                alignment: Alignment.center,
                child: Text(
                  "Email :- ${users.email}",
                  style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Material(
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                side: BorderSide(color: Colors.blue, width: 1.5),
              ),
              color: Colors.blue.shade700,
              child: Container(
                height: 70,
                width: 500,
                alignment: Alignment.center,
                child: Text(
                  "Number :- ${users.number}",
                  style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes().week2);
              },
              child: Container(
                height: 60,
                width: 500,
                alignment: Alignment.center,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue.shade800),
                child: const Text(
                  "Done",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
