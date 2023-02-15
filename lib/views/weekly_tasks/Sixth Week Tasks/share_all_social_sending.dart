import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SocialSharingPage extends StatefulWidget {
  const SocialSharingPage({Key? key}) : super(key: key);

  @override
  State<SocialSharingPage> createState() => _SocialSharingPageState();
}

class _SocialSharingPageState extends State<SocialSharingPage> {
  TextEditingController messageController = TextEditingController();
  String? message;
  GlobalKey<FormState> FormKey = GlobalKey<FormState>();
  List<XFile>? files = [];
  List<File>? file1 = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Social Sharing",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        alignment: Alignment.center,
        child: Form(
          key: FormKey,
          child: Column(
            children: [
              TextFormField(
                minLines: 1,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(color: Colors.white),
                controller: messageController,
                onSaved: (val) {
                  message = val!;
                },
                decoration: InputDecoration(
                  label: const Text(
                    "Message",
                    style: TextStyle(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.white70,
                      width: 1.0,
                    ),
                  ),
                  hintStyle: const TextStyle(color: Colors.white),
                  hintText: "Enter your Message here",
                  fillColor: Colors.white24,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.white70,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // ignore: unnecessary_null_comparison
              GestureDetector(
                onTap: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

                  if (result != null) {
                    result.files.map((e) => files?.add(XFile(e.path!))).toList();

                    result.files.map((e) => file1?.add(File(e.path!))).toList();
                    setState(() {});
                  } else {}
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 3, color: Colors.grey),
                  ),
                  child: (file1!.isEmpty)
                      ? const Text("Not File Attach", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold))
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: file1?.length,
                          itemBuilder: (context, i) => (file1![i].path.split('.').last == "jpg" ||
                                  file1![i].path.split('.').last == 'jpeg' ||
                                  file1![i].path.split('.').last == 'png')
                              ? Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipOval(
                                        child: Image.file(
                                          File(file1![i].path),
                                          fit: BoxFit.cover,
                                          height: 70,
                                          width: 70,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: -7,
                                      top: 7,
                                      bottom: 60,
                                      child: IconButton(
                                        onPressed: () {
                                          showDialog<void>(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Remove Files'),
                                                content: const Text('Are you sure you want to Remove That File...'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('Cancel'),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        files!.remove(files![i]);
                                                        file1!.remove(file1![i]);
                                                      });
                                                      Navigator.of(context).pop();
                                                    },
                                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                                    child: const Text('Remove File', style: TextStyle(color: Colors.white)),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.remove_circle,
                                          color: Colors.redAccent,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipOval(
                                        child: Container(
                                          height: 70,
                                          width: 70,
                                          color: Colors.white70,
                                          child: Center(
                                            child: Text(
                                              ".${file1![i].path.split('.').last}",
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: -7,
                                      top: 7,
                                      bottom: 60,
                                      child: IconButton(
                                        onPressed: () {
                                          showDialog<void>(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Remove Files'),
                                                content: const Text('Are you sure you want to Remove That File...'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('Cancel'),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        files!.remove(files![i]);
                                                        file1!.remove(file1![i]);
                                                      });
                                                      Navigator.of(context).pop();
                                                    },
                                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                                    child: const Text('Remove File', style: TextStyle(color: Colors.white)),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.remove_circle,
                                          color: Colors.red,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  if (FormKey.currentState!.validate()) {
                    FormKey.currentState!.save();
                    if (files!.isEmpty & messageController.text.isNotEmpty) {
                      Share.share(messageController.text);
                    } else if (files!.isNotEmpty) {
                      Share.shareXFiles(files!, text: messageController.text);
                    } else {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Alert Message'),
                            content: const Text('You Must Be Enter Text Or Files...'),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {});
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Ok', style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                child: Container(
                  height: 60,
                  width: 500,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue.shade800),
                  child: const Text(
                    "Send Message",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
