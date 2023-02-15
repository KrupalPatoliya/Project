import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_app/helpers/fire_base/firebaseauthhelpper.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({Key? key}) : super(key: key);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  int _selectedIndex = 0;

  PageController pageController = PageController();
  final TextEditingController passWordController = TextEditingController();
  late String passWord;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _visiblePassword = false;

  SharedPreferences? prefs;

  late String email;
  late String name;
  late String uid;

  getData() async {
    prefs = await SharedPreferences.getInstance();
    email = prefs!.getString(
      'email',
    )!;
    name = prefs!.getString(
      'name',
    )!;
    uid = prefs!.getString(
      'photo',
    )!;
  }

  @override
  Widget build(BuildContext context) {
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
            _selectedIndex = val;
            pageController.animateToPage(val, duration: const Duration(microseconds: 100), curve: Curves.ease);
          });
        },
        backgroundColor: Theme.of(context).backgroundColor,
        selectedItemColor: Colors.blue,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.white,
      ),
      body: PageView(
        onPageChanged: (val) {
          setState(() {
            _selectedIndex = val;
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
          Column(
            children: [
              const Center(
                child: Text(
                  "Details",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Text(
                email,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () async {
                  FireBaseAuthHelpper.fireBaseAuthHelpper.firebaseAuth.signOut();
                  prefs = await SharedPreferences.getInstance();
                  prefs!.setBool('isLogIn', true);
                },
                child: Container(
                  height: 50,
                  width: 250,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white24, border: Border.all(color: Colors.white, width: 2)),
                  alignment: Alignment.center,
                  child: const Text(
                    "Log Out",
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Form(
              key: formKey,
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
                    obscureText: !_visiblePassword,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    style: const TextStyle(color: Colors.black54),
                    controller: passWordController,
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
                      passWord = val!;
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
                            _visiblePassword = !_visiblePassword;
                          });
                        },
                        child: Icon(
                          _visiblePassword ? Icons.visibility_off : Icons.visibility,
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
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        FireBaseAuthHelpper.fireBaseAuthHelpper.changePassword(passWord);
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
        ],
      ),
    );
  }
}
