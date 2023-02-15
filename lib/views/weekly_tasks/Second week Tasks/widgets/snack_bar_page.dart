import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarPage extends StatefulWidget {
  const SnackBarPage({Key? key}) : super(key: key);

  @override
  State<SnackBarPage> createState() => _SnackBarPageState();
}

class _SnackBarPageState extends State<SnackBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text("Snack Bar"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Hello",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.blueAccent,
                  ),
                );
              },
              child: const Text(
                "Android Alert Box",
                style: TextStyle(fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) => CupertinoActionSheet(
                    title: const Text('Choose Options'),
                    message: const Text('Your options are'),
                    actions: <Widget>[
                      CupertinoActionSheetAction(
                        child: const Text('Ok'),
                        onPressed: () {
                          Navigator.pop(context, 'Ok');
                        },
                      ),
                      CupertinoActionSheetAction(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context, 'Cancel');
                        },
                      )
                    ],
                  ),
                );
              },
              child: const Text(
                "IOS Alert Box",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
