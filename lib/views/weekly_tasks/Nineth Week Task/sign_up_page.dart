import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:training_app/helpers/fire_base/firebaseauthhelpper.dart';

import '../../../utils/app_routes.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _visiblePassword = false;
  bool confirmvisiblePassword = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();
  late String userName;
  final TextEditingController nameController = TextEditingController();
  late String name;
  final TextEditingController passWordController = TextEditingController();
  late String passWord;
  final TextEditingController passWord2Controller = TextEditingController();
  late String passWord2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Sign In"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.text,
                            style: const TextStyle(color: Colors.white),
                            controller: userNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter a valid User Name';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) {
                              userName = val!;
                            },
                            decoration: InputDecoration(
                              label: const Text(
                                "User Name",
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
                              hintText: "Enter your Name here",
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
                            height: 20,
                          ),
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
                              hintText: "abc@gmail.com",
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
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: !_visiblePassword,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            style: const TextStyle(color: Colors.white),
                            controller: passWordController,
                            validator: (value) {
                              String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                              RegExp regex = RegExp(pattern);
                              if (value == null || value.isEmpty || !regex.hasMatch(value) || value.length < 6) {
                                return 'Enter a valid  PassWord';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) {
                              passWord = val!;
                            },
                            decoration: InputDecoration(
                              label: const Text(
                                "PassWord",
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
                              hintText: "abc@123",
                              fillColor: Colors.white24,
                              filled: true,
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    _visiblePassword = !_visiblePassword;
                                  });
                                },
                                child: Icon(
                                  _visiblePassword ? Icons.visibility_off : Icons.visibility,
                                  color: const Color(0xff3ea69e),
                                ),
                              ),
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
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: !confirmvisiblePassword,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            style: const TextStyle(color: Colors.white),
                            controller: passWord2Controller,
                            validator: (value) {
                              String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                              RegExp regex = RegExp(pattern);
                              if (value == null || value.isEmpty || !regex.hasMatch(value) || value.length < 6) {
                                return 'Enter a valid Password';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) {
                              passWord2 = val!;
                            },
                            decoration: InputDecoration(
                              label: const Text(
                                "Confirm PassWord",
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
                              hintText: "abc@123",
                              fillColor: Colors.white24,
                              filled: true,
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    confirmvisiblePassword = !confirmvisiblePassword;
                                  });
                                },
                                child: Icon(
                                  confirmvisiblePassword ? Icons.visibility_off : Icons.visibility,
                                  color: const Color(0xff3ea69e),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Colors.white70,
                                  width: 3.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 70),
                          InkWell(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();

                                if (passWord == passWord2) {
                                  User? user =
                                      await FireBaseAuthHelpper.fireBaseAuthHelpper.signUp(email: name, password: passWord, name: userName);

                                  if (user != null) {
                                    Navigator.of(context).pop();
                                    formKey.currentState!.reset();
                                  }
                                } else if (passWord != passWord2) {
                                  Fluttertoast.showToast(
                                      msg: "Please Check Conform PassWord Are Not same",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              }
                            },
                            child: Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                color: const Color(0xff327d7a),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
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
