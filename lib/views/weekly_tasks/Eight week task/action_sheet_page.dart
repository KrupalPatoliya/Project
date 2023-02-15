import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ActionSheetPage extends StatefulWidget {
  const ActionSheetPage({Key? key}) : super(key: key);

  @override
  State<ActionSheetPage> createState() => _ActionSheetPageState();
}

class _ActionSheetPageState extends State<ActionSheetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("ActionSheet And PopOver"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  barrierDismissible: true,
                  barrierColor: Colors.white60,
                  builder: (BuildContext context) => CupertinoActionSheet(
                    title: const Text(
                      'Choose Options',
                      style: TextStyle(
                        // color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    message: const Text(
                      'Your options are',
                      style: TextStyle(
                        // color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    actions: <Widget>[
                      CupertinoActionSheetAction(
                        child: const Text('One'),
                        onPressed: () async {
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "One Pressed",
                              toastLength: Toast.LENGTH_LONG,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                      ),
                      CupertinoActionSheetAction(
                        child: const Text('Two'),
                        onPressed: () {
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Two Pressed",
                              toastLength: Toast.LENGTH_LONG,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                      )
                    ],
                    cancelButton: CupertinoActionSheetAction(
                      isDestructiveAction: true,
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                );
              },
              child: const Text("iOS ActionSheet"),
            ),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ListTile(
                            title: const Center(child: Text('Photo')),
                            onTap: () {
                              Fluttertoast.showToast(
                                  msg: "Photo Pressed",
                                  toastLength: Toast.LENGTH_LONG,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: const Center(child: Text('Music')),
                            onTap: () {
                              Navigator.pop(context);
                              Fluttertoast.showToast(
                                  msg: "Music Pressed",
                                  toastLength: Toast.LENGTH_LONG,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            },
                          ),
                          ListTile(
                            title: const Center(child: Text('Video')),
                            onTap: () {
                              Navigator.pop(context);
                              Fluttertoast.showToast(
                                  msg: "Video Pressed",
                                  toastLength: Toast.LENGTH_LONG,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            },
                          ),
                          ListTile(
                            title: const Center(child: Text('Share')),
                            onTap: () {
                              Navigator.pop(context);
                              Fluttertoast.showToast(
                                  msg: "Share Pressed",
                                  toastLength: Toast.LENGTH_LONG,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            },
                          ),
                          ListTile(
                            title: const Center(
                                child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.blue),
                            )),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              },
              child: const Text("Android ActionSheet"),
            ),
            const Buttons(),
          ],
        ),
      ),
    );
  }
}

class Buttons extends StatefulWidget {
  const Buttons({Key? key}) : super(key: key);

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          showPopover(
            context: context,
            bodyBuilder: (context) => const ListItems(),
            onPop: () => print('Popover was popped!'),
            direction: PopoverDirection.bottom,
            width: 150,
            height: 300,
            arrowHeight: 15,
            arrowWidth: 30,
          );
        },
        child: const Text("PopOver"));
  }
}

class ListItems extends StatefulWidget {
  const ListItems({Key? key}) : super(key: key);

  @override
  State<ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Fluttertoast.showToast(
                    msg: "Entry A Pressed",
                    toastLength: Toast.LENGTH_LONG,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.amber[600],
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              child: Container(
                height: 50,
                color: Colors.amber[600],
                child: const Center(child: Text('Entry A')),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Fluttertoast.showToast(
                    msg: "Entry B Pressed",
                    toastLength: Toast.LENGTH_LONG,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.amber[500],
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              child: Container(
                height: 50,
                color: Colors.amber[500],
                child: const Center(child: Text('Entry B')),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Fluttertoast.showToast(
                    msg: "Entry C Pressed",
                    toastLength: Toast.LENGTH_LONG,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.amber[400],
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              child: Container(
                height: 50,
                color: Colors.amber[400],
                child: const Center(child: Text('Entry C')),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Fluttertoast.showToast(
                    msg: "Entry D Pressed",
                    toastLength: Toast.LENGTH_LONG,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.amber[300],
                    textColor: Colors.black,
                    fontSize: 16.0);
              },
              child: Container(
                height: 50,
                color: Colors.amber[300],
                child: const Center(child: Text('Entry D')),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Fluttertoast.showToast(
                    msg: "Entry E Pressed",
                    toastLength: Toast.LENGTH_LONG,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.amber[200],
                    textColor: Colors.black,
                    fontSize: 16.0);
              },
              child: Container(
                height: 50,
                color: Colors.amber[200],
                child: const Center(child: Text('Entry E')),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Fluttertoast.showToast(
                    msg: "Entry F Pressed",
                    toastLength: Toast.LENGTH_LONG,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.amber[100],
                    textColor: Colors.black,
                    fontSize: 16.0);
              },
              child: Container(
                height: 50,
                color: Colors.amber[100],
                child: const Center(child: Text('Entry F')),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Fluttertoast.showToast(
                    msg: "Entry G Pressed",
                    toastLength: Toast.LENGTH_LONG,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.amber[50],
                    textColor: Colors.black,
                    fontSize: 16.0);
              },
              child: Container(
                height: 50,
                color: Colors.amber[50],
                child: const Center(child: Text('Entry G')),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
