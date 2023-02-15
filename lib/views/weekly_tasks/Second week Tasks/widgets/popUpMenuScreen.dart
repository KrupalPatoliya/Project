import 'package:flutter/material.dart';

class PopUpMenuScreen extends StatefulWidget {
  const PopUpMenuScreen({Key? key}) : super(key: key);

  @override
  State<PopUpMenuScreen> createState() => _PopUpMenuScreenState();
}

enum Menu { One, Two, Three, Four, Five }

class _PopUpMenuScreenState extends State<PopUpMenuScreen> {
  String _selectedMenu = 'One';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Pop Up Menu Button"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                _selectedMenu = value.name;
              });
            },
            itemBuilder: (context) => Menu.values
                .map(
                  (e) => PopupMenuItem<Menu>(
                    value: e,
                    child: Text(e.name),
                  ),
                )
                .toList(),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_selectedMenu,
                style: const TextStyle(fontSize: 20, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
