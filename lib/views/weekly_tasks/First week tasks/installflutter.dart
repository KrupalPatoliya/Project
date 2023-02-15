import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InstallFlutter extends StatefulWidget {
  const InstallFlutter({Key? key}) : super(key: key);

  @override
  State<InstallFlutter> createState() => _InstallFlutterState();
}

class _InstallFlutterState extends State<InstallFlutter> with WidgetsBindingObserver {
  void buildCalled() {
    Fluttertoast.showToast(msg: "app is in build", toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.green, gravity: ToastGravity.BOTTOM);
  }

  void initStateCalled() {
    Fluttertoast.showToast(msg: "app is in InitState", toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.green, gravity: ToastGravity.CENTER);
  }

  void deactivateCalled() {
    Fluttertoast.showToast(msg: "app is in Deactivate", toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.green);
  }

  void disposeCalled() {
    Fluttertoast.showToast(msg: "app is in Disposed", toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.green, gravity: ToastGravity.CENTER);
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    initStateCalled();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        Fluttertoast.showToast(msg: "app is in InActive", toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.green);
        break;
      case AppLifecycleState.resumed:
        Fluttertoast.showToast(msg: "app is in Resumed", toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.green);
        break;
      case AppLifecycleState.paused:
        Fluttertoast.showToast(msg: "app is in Paused", toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.green);
        break;
      case AppLifecycleState.detached:
        Fluttertoast.showToast(msg: "app is in Detached", toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.green);
        break;
    }
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    deactivateCalled();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // TODO: implement dispose
    super.dispose();
    disposeCalled();
  }

  @override
  Widget build(BuildContext context) {
    buildCalled();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text("Life cycle/activity"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "App Life Cycle",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
