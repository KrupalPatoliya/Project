import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:training_app/models/employee.dart';
import 'package:flutter/services.dart';
import '../../../helpers/database_helpper/database_helpper_class.dart';

// ignore: must_be_immutable
class UpdateData extends StatefulWidget {
  Employee employee;

  UpdateData({Key? key, required this.employee}) : super(key: key);

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  TextEditingController updateAgeController = TextEditingController();
  TextEditingController updateNameController = TextEditingController();
  TextEditingController updateSalaryController = TextEditingController();

  ImagePicker _picker = ImagePicker();
  Uint8List? imageFile;
  XFile? image;
  Uint8List? bytes;

  String updateName = "";
  int updateAge = 0;
  int updateSalary = 0;
  int? id;

  GlobalKey<FormState> addEmployee = GlobalKey<FormState>();
  GlobalKey<FormState> updateEmployee = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      updateNameController.text = widget.employee.name;
      updateAgeController.text = widget.employee.age.toString();
      updateSalaryController.text = widget.employee.salary.toString();
      imageFile = widget.employee.image;
      bytes = widget.employee.image;

      id = widget.employee.id;
      setState(() {});
    });
    DataBaseHelpper.dataBaseHelpper.initDB();
    _picker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Update User"),
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
                    bytes = await image!.readAsBytes();
                    if (image != null) {
                      imageFile = await image!.readAsBytes();
                      setState(() {});
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
                    child: (imageFile == null)
                        ? const Icon(
                            Icons.perm_identity_outlined,
                            color: Colors.grey,
                          )
                        : Image.memory(imageFile!),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: Colors.white),
                  controller: updateNameController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Name First...";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    updateName = val!;
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
                  style: const TextStyle(color: Colors.white),
                  controller: updateAgeController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Age First...";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    updateAge = int.parse(val!);
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
                  controller: updateSalaryController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Salary First...";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    updateSalary = int.parse(val!);
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
                        updateName = "";
                        updateAge = 0;
                        updateSalary = 00;

                        updateNameController.clear();
                        updateSalaryController.clear();
                        updateAgeController.clear();
                        Navigator.of(context).pop();
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

                          DataBaseHelpper.dataBaseHelpper.updateData(id: id!, name: updateName, image: bytes!, salary: updateSalary, age: updateAge);

                          updateName = "";
                          updateAge = 0;
                          updateSalary = 00;

                          updateNameController.clear();
                          updateSalaryController.clear();
                          updateAgeController.clear();

                          Navigator.of(context).pop();
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Update"),
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
