import 'package:flutter/material.dart';

class ShareDefaultIntentPage extends StatefulWidget {
  const ShareDefaultIntentPage({Key? key}) : super(key: key);

  @override
  State<ShareDefaultIntentPage> createState() => _ShareDefaultIntentPageState();
}

class _ShareDefaultIntentPageState extends State<ShareDefaultIntentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Share Default Intent",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
