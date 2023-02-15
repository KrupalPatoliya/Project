import 'package:flutter/material.dart';

class DropDownButtonPage extends StatefulWidget {
  const DropDownButtonPage({Key? key}) : super(key: key);

  @override
  State<DropDownButtonPage> createState() => _DropDownButtonPageState();
}

class _DropDownButtonPageState extends State<DropDownButtonPage> {
  String dropDownValue = 'one';

  var items = [
    'one',
    'two',
    'Three',
    'four',
    'fifth',
    'Six',
    'Seven',
    'Eight',
    'Nine',
    'ten'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Drop down Button"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.blue.shade100,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: DropdownButton(
                focusColor: Colors.white,
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items,
                        style: TextStyle(
                            color: Colors.blue.shade900, fontSize: 25)),
                  );
                }).toList(),
                value: dropDownValue,
                icon: Icon(Icons.keyboard_arrow_down,
                    color: Colors.blue.shade900),
                onChanged: (val) {
                  setState(() {
                    dropDownValue = val!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
