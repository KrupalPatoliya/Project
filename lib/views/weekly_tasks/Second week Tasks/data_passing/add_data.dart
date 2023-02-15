import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:training_app/models/users_data.dart';
import 'showdata.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({Key? key}) : super(key: key);

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  GlobalKey<FormState> FormKey = GlobalKey<FormState>();

  ImagePicker _picker = ImagePicker();
  File? imageFile;

  final TextEditingController _nameController = TextEditingController();
  late String name;
  final TextEditingController _numberController = TextEditingController();
  late String number;
  final TextEditingController _emailController = TextEditingController();
  late String email;

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
        title: const Text("Pass data"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,

      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Form(
          key: FormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  // PickedFile? pickedFile = await ImagePicker().getImage(
                  //   source: ImageSource.gallery,
                  //   maxWidth: 1800,
                  //   maxHeight: 1800,
                  // );

                  XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      imageFile = File(image.path);
                    });
                  }
                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(15),
                    border: Border(
                      top: BorderSide(color: Colors.blue.shade900, width: 3),
                      right: BorderSide(color: Colors.blue.shade900, width: 3),
                      bottom: BorderSide(color: Colors.blue.shade900, width: 3),
                      left: BorderSide(color: Colors.blue.shade900, width: 3),
                    ),
                  ),
                  child: (imageFile == null)
                      ? Icon(Icons.person_add_outlined,
                          size: 60, color: Colors.blue.shade900)
                      : Image.file(imageFile!),
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.white),
                controller: _nameController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter your name ...";
                  }
                  return null;
                },
                onSaved: (val) {
                  name = val!;
                },
                decoration: InputDecoration(
                  label: const Text(
                    "User Name",
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
                  hintText: "Enter your name here",
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
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.white),
                controller: _numberController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter your Number...";
                  } else if (val.length != 10) {
                    return "Enter your Number of 10th digits..";
                  }
                  return null;
                },
                onSaved: (val) {
                  number = val!;
                },
                decoration: InputDecoration(
                  label: const Text(
                    "Number",
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
                  hintText: "Enter your Number here",
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
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white),
                controller: _emailController,
                validator: (value) {
                  String pattern =
                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                      r"{0,253}[a-zA-Z0-9])?)*$";
                  RegExp regex = RegExp(pattern);
                  if (value == null ||
                      value.isEmpty ||
                      !regex.hasMatch(value)) {
                    return 'Enter a valid email address';
                  } else {
                    return null;
                  }
                },
                onSaved: (val) {
                  email = val!;
                },
                decoration: InputDecoration(
                  label: const Text(
                    "Email",
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
                  hintText: "Enter your Email here",
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
                onTap: () {
                  if (FormKey.currentState!.validate()) {
                    FormKey.currentState!.save();

                    Users add = Users(
                        name: name,
                        email: email,
                        number: number,
                        image: imageFile!);

                    _nameController.text = name;
                    _numberController.text = number;
                    _emailController.text = email;
                    imageFile = imageFile;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShowDataScreen(),
                        settings: RouteSettings(
                          arguments: add,
                        ),
                      ),
                    );
                  }

                },
                child: Container(
                  height: 60,
                  width: 500,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.shade800),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
