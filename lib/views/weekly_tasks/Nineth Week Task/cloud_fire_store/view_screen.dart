import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:training_app/helpers/fire_base/fireBaseCloudHelpper.dart';

class ShowDataPage extends StatefulWidget {
  const ShowDataPage({Key? key}) : super(key: key);

  @override
  State<ShowDataPage> createState() => _ShowDataPageState();
}

class _ShowDataPageState extends State<ShowDataPage> {
  final TextEditingController task_descriptionController = TextEditingController();
  late String task_description;

  final TextEditingController task_titleController = TextEditingController();
  late String task_title;

  TextEditingController dateInput = TextEditingController();

  String? status = "Pending";
  DateTime? pickedDate = DateTime.now();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String createDate;
  late String doneDate;

  @override
  void initState() {
    dateInput.text = DateFormat('yyyy-MM-dd').format(pickedDate!).toString();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Add Data"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.white),
                controller: task_titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a Title';
                  } else {
                    return null;
                  }
                },
                onSaved: (val) {
                  task_title = val!;
                },
                decoration: InputDecoration(
                  label: const Text(
                    "Title",
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
                  hintText: "Enter your Title here",
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
                maxLines: 4,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.white),
                controller: task_descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a Description';
                  } else {
                    return null;
                  }
                },
                onSaved: (val) {
                  task_description = val!;
                },
                decoration: InputDecoration(
                  label: const Text(
                    "Description",
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
                  hintText: "Enter your Description here",
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
                readOnly: true,
                onTap: () async {
                  pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    print(pickedDate);
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate!);
                    print(formattedDate);

                    setState(() {
                      dateInput.text = formattedDate;
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
                style: TextStyle(color: Colors.white),
                controller: dateInput,
                decoration: InputDecoration(
                  label: const Text(
                    "Date",
                    style: TextStyle(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.white70,
                      width: 1.0,
                    ),
                  ),
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
              const Text(
                "Status",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RadioListTile(
                    value: "Pending",
                    groupValue: status,
                    onChanged: (value) {
                      setState(() {
                        status = value.toString();
                      });
                    },
                    title: const Text(
                      "Pending",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                  ),
                  RadioListTile(
                    value: "Done",
                    groupValue: status,
                    onChanged: (value) {
                      setState(() {
                        status = value.toString();
                      });
                    },
                    title: const Text(
                      "Done",
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
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    FireBaseCloudHelpper.fireBaseCloudHelpper.addUser(
                      task_description: task_descriptionController.text,
                      task_title: task_titleController.text,
                      createDate: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
                      doneDate: dateInput.text,
                      status: status!,
                    );

                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  height: 55,
                  width: 350,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white24, border: Border.all(color: Colors.white, width: 2)),
                  alignment: Alignment.center,
                  child: const Text(
                    "Add Data",
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
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
