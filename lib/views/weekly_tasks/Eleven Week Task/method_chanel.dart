import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodChanelPage extends StatefulWidget {
  const MethodChanelPage({Key? key}) : super(key: key);

  @override
  State<MethodChanelPage> createState() => _MethodChanelPageState();
}

class _MethodChanelPageState extends State<MethodChanelPage> {
  static const MethodChannel platform = MethodChannel('GetNumber');

  String numberFinal = "No data Found";

  Future<void> _generateRandomNumber() async {
    String number;
    try {
      String result = await platform.invokeMethod('getRandomNumber');
      number = result;
    } on PlatformException catch (e) {
      print(e);
      number = "${e.message}";
    }
    if (numberFinal != number) {
      setState(() {
        numberFinal = number.toString();
      });
    }

    if (mounted) {
      _generateRandomNumber();
    } else if (mounted == false) {
      return;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generateRandomNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Method Chanel"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              numberFinal,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
