import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../helpers/database_helpper/database_helpper_class.dart';

class InsertData extends StatefulWidget {
  const InsertData({Key? key}) : super(key: key);

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  String name = "";
  int age = 0;
  int salary = 0;

  ImagePicker _picker = ImagePicker();
  File? imageFile;
  XFile? image;

  GlobalKey<FormState> addEmployee = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DataBaseHelpper.dataBaseHelpper.initDB();
    _picker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("SqLite DB"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: addEmployee,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    image = await _picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      setState(() {
                        imageFile = File(image!.path);
                      });
                    }
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white70, width: 4),
                    ),
                    child: (imageFile == null) ? const Icon(Icons.camera_alt_outlined, size: 40, color: Colors.blue) : Image.file(imageFile!),
                  ),
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
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  style: const TextStyle(color: Colors.white),
                  controller: ageController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Age First...";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    age = int.parse(val!);
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
                    labelText: "Age",
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
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  controller: salaryController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Salary First...";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    salary = int.parse(val!);
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
                    labelText: "Salary",
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
                Row(
                  children: [
                    const Spacer(),
                    OutlinedButton(
                      style: const ButtonStyle().copyWith(
                        side: MaterialStatePropertyAll(
                          BorderSide(color: Colors.blue.shade900, width: 3),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        name = "";
                        age = 0;
                        salary = 00;
                        // imageFile!.delete(recursive: false);

                        nameController.clear();
                        salaryController.clear();
                        ageController.clear();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Cancel", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (addEmployee.currentState!.validate()) {
                          addEmployee.currentState!.save();

                          if (image != null) {
                            Uint8List bytes = await image!.readAsBytes();

                            DataBaseHelpper.dataBaseHelpper.insertData(name: name, image: bytes, salary: salary, age: age);

                            name = "";
                            age = 0;
                            salary = 00;

                            nameController.clear();
                            salaryController.clear();
                            ageController.clear();

                            Navigator.of(context).pop();
                          }else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  "Please pick Image",
                                ),
                              ),
                            );
                          }
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("ADD"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
