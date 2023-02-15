import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:training_app/utils/app_routes.dart';

class SaveFileLocallyPage extends StatefulWidget {
  const SaveFileLocallyPage({Key? key}) : super(key: key);

  @override
  State<SaveFileLocallyPage> createState() => _SaveFileLocallyPageState();
}

class _SaveFileLocallyPageState extends State<SaveFileLocallyPage> {
  TextEditingController messageController = TextEditingController();
  String? message;
  TextEditingController nameController = TextEditingController();
  String? name;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("File Create"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        alignment: Alignment.center,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.deny("."),
                  FilteringTextInputFormatter.deny(" "),
                  LengthLimitingTextInputFormatter(15),
                ],
                style: const TextStyle(color: Colors.white),
                controller: nameController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter your File Name...";
                  }
                  return null;
                },
                onSaved: (val) {
                  name = val!;
                },
                decoration: InputDecoration(
                  label: const Text(
                    "File Name",
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
                  hintText: "Enter File Name here",
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
              const SizedBox(height: 20),
              TextFormField(
                minLines: 5,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(color: Colors.white),
                controller: messageController,
                onSaved: (val) {
                  message = val!;
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter your Message...";
                  }
                  return null;
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
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    final directory = (await getExternalStorageDirectories(type: StorageDirectory.downloads))!.first;

                    print(directory);

                    File file2 = File("${directory.path}/${nameController.text}.txt");

                    await file2.writeAsString(messageController.text).then((value) {
                      Fluttertoast.showToast(
                        msg: "Save File Successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      nameController.clear();
                      messageController.clear();
                      name = "";
                      message = "";
                    });
                  }
                },
                child: Container(
                  height: 60,
                  width: 400,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.shade900,
                  ),
                  child: const Text(
                    "Save File",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes().viewFileLocallyScreen);
                },
                child: Container(
                  height: 60,
                  width: 400,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.shade900,
                  ),
                  child: const Text(
                    "View Files",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
