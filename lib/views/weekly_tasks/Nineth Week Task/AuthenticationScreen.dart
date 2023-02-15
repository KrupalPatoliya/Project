import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_app/helpers/fire_base/firebaseauthhelpper.dart';
import '../../../utils/app_routes.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool _visiblePassword = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  late String name;
  final TextEditingController passWordController = TextEditingController();
  late String passWord;

  final TextEditingController passWordChangeController = TextEditingController();
  late String passWordChange;

  GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  bool password = false;

  int selectedIndex = 0;
  PageController pageController = PageController();

  SharedPreferences? prefs;
  UserCredential? user;

  setStateCall() {
    setState(() {});
  }

  bool? isLogIn = true;

  addData({required String email, required String name, required String photo}) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString('email', email);
    prefs!.setString('name', name);
    prefs!.setString('photo', photo);
    // prefs!.setBool('isLogIn', true);
  }

  removeData() async {
    prefs = await SharedPreferences.getInstance();
    prefs!.remove('email');
    prefs!.remove('name');
    prefs!.remove('photo');
  }

  initIsLogIn() async {
    prefs = await SharedPreferences.getInstance();

    isLogIn = prefs!.getBool("isLogIn")!;
    setState(() {});
  }

  @override
  void initState() {
    initIsLogIn();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    if ((isLogIn!)) {
      return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              title: const Text("Log In"),
              elevation: 0,
              centerTitle: true,
              backgroundColor: Theme.of(context).backgroundColor,
            ),
            body: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
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
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: !_visiblePassword,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        style: const TextStyle(color: Colors.white),
                        controller: passWordController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter your PassWord ...";
                          }
                          return null;
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
                          hintText: "Enter your PassWord here",
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
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () async {
                              // if (formKey.currentState!.validate()) {
                              //   formKey.currentState!.save();
                              //
                              //   User? user = await FireBaseAuthHelpper.fireBaseAuthHelpper.resetPassword(
                              //     email: name,
                              //   );

                              Navigator.of(context).pushNamed(AppRoutes().forGotPassWordScreen);
                              // }
                            },
                            child: const Text(
                              "Forgot Password ?",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 70),
                      InkWell(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            User? users =
                                await FireBaseAuthHelpper.fireBaseAuthHelpper.signIn(email: nameController.text, password: passWordController.text);

                            addData(
                                email: nameController.text.toString(),
                                name: nameController.text.split('@').first.toString(),
                                photo: users!.uid.toString());
                            prefs!.setBool('isLogIn', false);

                            formKey.currentState!.reset();

                            setState(() {
                              nameController.clear();
                              passWordController.clear();
                              name = "";
                              passWord = "";
                              isLogIn = prefs!.getBool('isLogIn')!;
                              setStateCall();
                            });
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
                            "Log In",
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "OR",
                        style: TextStyle(color: Colors.grey),
                      ),const SizedBox(height: 20),
                      SignInButton(
                        // mini: true,
                        Buttons.Google,
                        text: "Sign up with Google",
                        onPressed: () async {

                          OAuthCredential credential = await FireBaseAuthHelpper.fireBaseAuthHelpper.signInWithGoogle();

                          user = await FireBaseAuthHelpper.fireBaseAuthHelpper.firebaseAuth.signInWithCredential(credential);
                          addData(email: user!.user!.email.toString(), name: user!.user!.displayName.toString(), photo: user!.user!.photoURL.toString());
                          prefs!.setBool('isLogIn', false);
                          setState(() {
                            nameController.clear();
                            passWordController.clear();
                            name = "";
                            passWord = "";
                            isLogIn = prefs!.getBool('isLogIn')!;
                            setStateCall();
                          });
                        },
                      ),
                      SignInButton(
                        // mini: true,
                        Buttons.Facebook,
                        text: "Sign up with FaceBook",
                        onPressed: () async {
                          user = await FireBaseAuthHelpper.fireBaseAuthHelpper.signInWithFacebook();
                          addData(email: user!.user!.email.toString(), name: user!.user!.displayName.toString(), photo: user!.user!.photoURL.toString());

                          prefs!.setBool('isLogIn', false);
                          setState(() {
                            nameController.clear();
                            passWordController.clear();
                            name = "";
                            passWord = "";
                            isLogIn = prefs!.getBool('isLogIn')!;
                            setStateCall();
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      const Divider(
                        color: Color(0xff327d7a),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRoutes().signUpScreen);
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
                            "Sign In",
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
    } else {
      return userLogIn();
    }
  }

  Widget userLogIn() {
    // prefs = SharedPreferences.getInstance() as SharedPreferences?;

    String? email = prefs!.getString('email') ?? "";
    String? name = prefs!.getString('name') ?? "";
    String? photo = prefs!.getString('photo') ?? "";

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("User Is Log In"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Details',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (val) {
          setState(() {
            selectedIndex = val;
            pageController.animateToPage(val, duration: const Duration(microseconds: 100), curve: Curves.ease);
            setStateCall();
          });
        },
        backgroundColor: Theme.of(context).backgroundColor,
        selectedItemColor: Colors.blue,
        currentIndex: selectedIndex,
        unselectedItemColor: Colors.white,
      ),
      body: PageView(
        onPageChanged: (val) {
          setState(() {
            selectedIndex = val;
            pageController.animateToPage(val, duration: const Duration(microseconds: 100), curve: Curves.ease);
          });
        },
        controller: pageController,
        children: [
          const Center(
            child: Text(
              "Welcome",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Details",
                      style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    ("Email :- $email!"),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Name :- $name",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "UID - $photo",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () async {
                      removeData();
                      FireBaseAuthHelpper.fireBaseAuthHelpper.firebaseAuth.signOut();
                      prefs = await SharedPreferences.getInstance();
                      setState(() {
                        prefs!.setBool('isLogIn', true);
                        isLogIn = prefs!.getBool('isLogIn') ?? true;
                        setStateCall();
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5), color: Colors.white24, border: Border.all(color: Colors.white, width: 2)),
                      alignment: Alignment.center,
                      child: const Text(
                        "Log Out",
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Form(
                key: formKey1,
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "New PassWord",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: !password,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      style: const TextStyle(color: Colors.white),
                      controller: passWordChangeController,
                      validator: (value) {
                        String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                        RegExp regex = RegExp(pattern);
                        if (value == null || value.isEmpty || !regex.hasMatch(value) || value.length < 6) {
                          return 'Enter a valid PassWord';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (val) {
                        passWordChange = val!;
                      },
                      decoration: InputDecoration(
                        label: const Text(
                          "New PassWord",
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
                              password = !password;
                            });
                          },
                          child: Icon(
                            password == true ? Icons.visibility_off : Icons.visibility,
                            color: Colors.white,
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
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (formKey1.currentState!.validate()) {
                          formKey1.currentState!.save();
                          FireBaseAuthHelpper.fireBaseAuthHelpper.changePassword(passWordChange);

                          passWordChangeController.clear();
                          passWordChange = "";
                          formKey1.currentState!.reset();
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 350,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), color: Colors.white24, border: Border.all(color: Colors.white, width: 2)),
                        alignment: Alignment.center,
                        child: const Text(
                          "Change PassWord",
                          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
