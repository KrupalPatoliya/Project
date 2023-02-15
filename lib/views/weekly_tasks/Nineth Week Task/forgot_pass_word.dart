import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:training_app/helpers/fire_base/firebaseauthhelpper.dart';

class ForGotPassWordPage extends StatefulWidget {
  const ForGotPassWordPage({Key? key}) : super(key: key);

  @override
  State<ForGotPassWordPage> createState() => _ForGotPassWordPageState();
}

class _ForGotPassWordPageState extends State<ForGotPassWordPage> {
  final TextEditingController nameController = TextEditingController();
  late String name;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("New PassWord"),
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
                style: const TextStyle(color: Colors.white),
                controller: nameController,
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
                  name = val!;
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
                      width: 2.0,
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
                      width: 3.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    try {
                      User? user = await FireBaseAuthHelpper.fireBaseAuthHelpper.resetPassword(
                        email: name,
                      );
                      Fluttertoast.showToast(
                          msg: "Sent Link SuccessFully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Navigator.of(context).pop();
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        Fluttertoast.showToast(
                            msg: "User Not Available",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (e.code == 'invalid-mail') {
                        Fluttertoast.showToast(
                            msg: "Email Not Found",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    }
                  }
                },
                child: Container(
                  height: 50,
                  width: 250,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white24, border: Border.all(color: Colors.white, width: 2)),
                  alignment: Alignment.center,
                  child: const Text(
                    "Send Mail",
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
