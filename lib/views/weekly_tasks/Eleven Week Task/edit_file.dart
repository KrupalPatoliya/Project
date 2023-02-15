import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class EditFileLocallyPage extends StatefulWidget {
  EditFileLocallyPage({Key? key, required this.file}) : super(key: key);
  File file;

  @override
  State<EditFileLocallyPage> createState() => _EditFileLocallyPageState();
}

class _EditFileLocallyPageState extends State<EditFileLocallyPage> {
  TextEditingController messageController = TextEditingController();
  String? message;
  TextEditingController nameController = TextEditingController();
  String? name;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  File? file;

  getData() async {
    file = widget.file;

    nameController.text = file!.path.split("/").last.split(".").first;

    messageController.text = await file!.readAsString();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }

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
                inputFormatters: [
                  FilteringTextInputFormatter.deny("."),
                  FilteringTextInputFormatter.deny(" "),
                  LengthLimitingTextInputFormatter(15),
                ],
                keyboardType: TextInputType.text,
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

                    file = widget.file;

                    final directory = (await getExternalStorageDirectories(type: StorageDirectory.downloads))!.first;

                    print(directory);


                    file!.writeAsStringSync(messageController.text);

                    file!.rename("${directory.path}/${nameController.text}.txt");
                    Navigator.of(context).pop();
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
                    "Edit File",
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
