import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:training_app/helpers/fire_base/fire_base_storage.dart';
import 'package:training_app/helpers/fire_base/real_time_data_base_helper.dart';
import 'package:training_app/utils/app_routes.dart';

class RealTimeDatabaseScreen extends StatefulWidget {
  const RealTimeDatabaseScreen({Key? key}) : super(key: key);

  @override
  State<RealTimeDatabaseScreen> createState() => _RealTimeDatabaseScreenState();
}

class _RealTimeDatabaseScreenState extends State<RealTimeDatabaseScreen> {
  // - Create Employee Table Which contain (id,name,designation,gender,mobile_no,salary,email)

  final TextEditingController nameController = TextEditingController();
  late String name;

  final TextEditingController designationController = TextEditingController();
  late String designation;

  final TextEditingController mobileNoController = TextEditingController();
  late String mobileNo;

  final TextEditingController salaryController = TextEditingController();
  late String salary;

  final TextEditingController emailController = TextEditingController();
  late String email;

  String? gender = "Male";
  String pic = "";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ImagePicker _picker = ImagePicker();
  File? imageFile;
  XFile? image;

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
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("RealTime Database"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
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
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: Colors.white),
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid Name';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (val) {
                    name = val!;
                  },
                  decoration: InputDecoration(
                    label: const Text(
                      "Name",
                      style: TextStyle(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    hintStyle: const TextStyle(color: Colors.white),
                    hintText: "Enter your Name here",
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
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: Colors.white),
                  controller: emailController,
                  validator: (value) {
                    String pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                        r"{0,253}[a-zA-Z0-9])?)*$";
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
                  decoration: InputDecoration(
                    label: const Text(
                      "Email",
                      style: TextStyle(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Colors.white,
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
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Colors.white),
                  controller: mobileNoController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter your Number...";
                    } else if (val.length != 10) {
                      return "Enter your Number of 10th digits..";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    mobileNo = val!;
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
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  controller: salaryController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter your Salary...";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    salary = val!;
                  },
                  decoration: InputDecoration(
                    label: const Text(
                      "Salary",
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
                    hintText: "Enter your Salary here",
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
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  minLines: 1,
                  maxLines: null,
                  style: const TextStyle(color: Colors.white),
                  controller: designationController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter your Designation...";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    designation = val!;
                  },
                  decoration: InputDecoration(
                    label: const Text(
                      "Designation",
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
                    hintText: "Enter your Designation here",
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
                  height: 10,
                ),
                const Text(
                  "Gender",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RadioListTile(
                      value: "Male",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                      title: const Text(
                        "Male",
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ),
                    RadioListTile(
                      value: "Female",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                      title: const Text(
                        "Female",
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ),
                    RadioListTile(
                      value: "Others",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                      title: const Text(
                        "Others",
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    if (formKey.currentState!.validate() && imageFile != null) {
                      formKey.currentState!.save();
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return const AlertDialog(
                              content: SizedBox(
                                width: 400,
                                height: 200,
                                child: Center(child: CircularProgressIndicator()),
                              ),
                            );
                          });

                      pic = await FireBaseStorageHelpper.fireBaseStorageHelpper.insertImage(file: imageFile!);
                      print(pic);

                      RealTimeDataBaseHelper.realTimeDataBaseHelper.addData(
                        pic: pic,
                        name: name,
                        email: email,
                        number: mobileNo,
                        salary: salary,
                        designation: designation,
                        gender: gender ?? "male",
                      );

                      formKey.currentState!.reset();
                      nameController.clear();
                      name = "";
                      designationController.clear();
                      designation = "";
                      mobileNoController.clear();
                      mobileNo = "";
                      salaryController.clear();
                      salary = "";
                      emailController.clear();
                      email = "";

                      setState(() {
                        imageFile = null;
                      });
                      Navigator.of(context).pop();
                    } else if (imageFile == null) {
                      Fluttertoast.showToast(
                          msg: "Add Image",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  child: Container(
                    height: 55,
                    width: 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5), color: Colors.white24, border: Border.all(color: Colors.white, width: 2)),
                    alignment: Alignment.center,
                    child: const Text(
                      "Add Data",
                      style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes().viewRealTimeDatabaseScreen);
                  },
                  child: Container(
                    height: 55,
                    width: 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5), color: Colors.white24, border: Border.all(color: Colors.white, width: 2)),
                    alignment: Alignment.center,
                    child: const Text(
                      "View Data",
                      style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
