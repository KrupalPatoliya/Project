import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:training_app/helpers/api_helpper/api_helpper.dart';

import '../../../models/api_model.dart';

// ignore: must_be_immutable
class UpdateApiDataPage extends StatefulWidget {
  UpdateApiDataPage({Key? key, required this.employee}) : super(key: key);
  Data? employee;

  @override
  State<UpdateApiDataPage> createState() => _UpdateApiDataPageState();
}

class _UpdateApiDataPageState extends State<UpdateApiDataPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String name = "";
  String email = "";
  int? id;

  ImagePicker _picker = ImagePicker();
  File? imageFile;
  XFile? image;

  String? image1;

  GlobalKey<FormState> addEmployee = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      nameController.text = widget.employee!.name!;
      emailController.text = widget.employee!.email!;
      imageFile = File(widget.employee!.profilePic!);
      image1 = widget.employee!.profilePic!;

      id = widget.employee!.userId!;
      setState(() {});
    });

    _picker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Update Data"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Form(
          key: addEmployee,
          child: Column(
            children: [
              Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white70, width: 4),
                ),
                child: (image1 == null) ? const Icon(Icons.camera_alt_outlined, size: 40, color: Colors.blue) : Image.network(image1!),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.white),
                controller: nameController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please Enter Name First...";
                  }
                  return null;
                },
                onSaved: (val) {
                  name = val!;
                },
                cursorColor: Colors.blueAccent,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.white70,
                      width: 1.0,
                    ),
                  ),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                  ),
                  labelText: "Name",
                  labelStyle: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                inputFormatters: [
                  // NoLeadingSpaceFormatter(),
                  // LowerCaseTextFormatter(),
                  FilteringTextInputFormatter.deny(RegExp("[ ]")),
                  FilteringTextInputFormatter.allow(RegExp("[a-zá-ú0-9.,-_@]")),
                  LengthLimitingTextInputFormatter(50),
                ],
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white),
                controller: emailController,
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regex = RegExp(pattern);
                  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
                    return 'Enter a valid email address';
                  } else {
                    return null;
                  }
                },
                onSaved: (val) {
                  email = val!;
                },
                cursorColor: Colors.blueAccent,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.white70,
                      width: 1.0,
                    ),
                  ),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                  ),
                  labelText: "Email",
                  labelStyle: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: const ButtonStyle().copyWith(
                      side: MaterialStatePropertyAll(
                        BorderSide(color: Colors.blue.shade900, width: 3),
                      ),
                    ),
                    onPressed: () {
                      name = "";
                      email = "";

                      nameController.clear();
                      emailController.clear();
                      Navigator.of(context).pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      child: Text("Cancel", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (addEmployee.currentState!.validate()) {
                        addEmployee.currentState!.save();

                        ApiHelpper.apiHelpper.upDateData(name: name, email: email, id: id!);

                        name = "";
                        email = "";

                        nameController.clear();
                        emailController.clear();

                        Navigator.of(context).pop();
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      child: Text("UPDATE", style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
