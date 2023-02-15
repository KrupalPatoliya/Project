import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class SharingPage extends StatefulWidget {
  const SharingPage({Key? key}) : super(key: key);

  @override
  State<SharingPage> createState() => _SharingPageState();
}

class _SharingPageState extends State<SharingPage> {
  TextEditingController messageController = TextEditingController();
  String? message;
  GlobalKey<FormState> FormKey = GlobalKey<FormState>();
  ImagePicker _picker = ImagePicker();
  File? imageFile;
  XFile? image;

  final FlutterShareMe flutterShareMe = FlutterShareMe();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _picker = ImagePicker();
  }

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
              GestureDetector(
                onLongPress: () {
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
                                imageFile = null;
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
                onTap: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false);

                  if (result != null) {
                    imageFile = File(result.files[0].path!);
                    setState(() {});
                  } else {}
                },
                child: Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white70, width: 4),
                  ),
                  child: (imageFile == null)
                      ? const Icon(Icons.camera_alt_outlined, size: 40, color: Colors.blue)
                      : (imageFile!.path.split('.').last == "jpg" ||
                              imageFile!.path.split('.').last == 'jpeg' ||
                              imageFile!.path.split('.').last == 'png')
                          ? Image.file(imageFile!)
                          : Center(
                              child: Text(
                                ".${imageFile!.path.split('.').last}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                ),
              ),
              const SizedBox(height: 30),
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
              const SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (FormKey.currentState!.validate()) {
                        FormKey.currentState!.save();
                        if (imageFile != null) {
                          var response =
                              await flutterShareMe.shareToWhatsApp(imagePath: imageFile!.path, msg: messageController.text).then((value) {});
                        } else {
                          var response = await flutterShareMe.shareToWhatsApp(msg: messageController.text);
                        }
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.green.shade400),
                      child: Icon(Icons.send, color: Colors.white, size: 35),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (messageController.text.isNotEmpty) {
                        var response = await flutterShareMe.shareToFacebook(
                            msg: messageController.text,
                            url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfjs7Q3Iauk6r3PxZf_JGrdVB4QUwuo1wtzg&usqp=CAU");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Enter Message First..."),
                            // backgroundColor: Colors.red,
                            // width: 200,
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.blue.shade800),
                      child: const Icon(Icons.facebook, color: Colors.white, size: 35),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (imageFile == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("When Yoy send message in Instagram where you Must be choose Image..."),
                            backgroundColor: Colors.red,
                            // width: 200,
                          ),
                        );
                      } else {
                        if (imageFile!.path.split('.').last == "jpg" ||
                            imageFile!.path.split('.').last == 'jpeg' ||
                            imageFile!.path.split('.').last == 'png') {
                          var response = await flutterShareMe.shareToInstagram(
                            filePath: imageFile!.path,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("You can only send Image File..."),
                              // width: 200,
                            ),
                          );
                        }
                      }

                      // https://www.instagram.com/direct/new/
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.pink.shade50,
                        image: const DecorationImage(
                          image: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfjs7Q3Iauk6r3PxZf_JGrdVB4QUwuo1wtzg&usqp=CAU",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              /* const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      var response = await flutterShareMe.shareToMessenger(
                        msg: messageController.text,
                      );
                      setState(() {});
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.green.shade400),
                      child: const Icon(Icons.message, color: Colors.white, size: 35),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (FormKey.currentState!.validate()) {
                        FormKey.currentState!.save();
                        var response = await flutterShareMe.shareToTwitter(
                          msg: messageController.text,
                        );
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black,
                        image: const DecorationImage(
                            image: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYhHy9CZ6GM8jQ3SFs-4yRqzw64pwhL3DjAQ&usqp=CAU",
                            ),
                            fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (FormKey.currentState!.validate()) {
                        FormKey.currentState!.save();
                        var response = await flutterShareMe.shareToTelegram(msg: messageController.text);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.blue,
                        image: const DecorationImage(
                          image: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVA8z1hT7N1qNITHH76b_3cdNkz2hMJWdszA&usqp=CAU",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
