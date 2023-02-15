import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training_app/helpers/fire_base/firebaseauthhelpper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_app/views/weekly_tasks/widgets/custombutton.dart';

class SocialMediaLogInPage extends StatefulWidget {
  const SocialMediaLogInPage({Key? key}) : super(key: key);

  @override
  State<SocialMediaLogInPage> createState() => _SocialMediaLogInPageState();
}

class _SocialMediaLogInPageState extends State<SocialMediaLogInPage> {
  bool _loading = false;
  bool? isLogin;
  bool isGoogle = false;

  void _onLoading() {
    setState(() {
      _loading = true;
      Future.delayed(const Duration(seconds: 4), _login);
    });
  }

  Future _login() async {
    setState(() {
      _loading = false;
    });
  }

  SharedPreferences? prefs;

  addData({required String email, required String name, required String photo}) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString('email', email);
    prefs!.setString('name', name);
    prefs!.setString('photo', photo);
    prefs!.setBool('isGoogle', isGoogle);
  }

  removeData() async {
    prefs = await SharedPreferences.getInstance();
    prefs!.remove('email');
    prefs!.remove('name');
    prefs!.remove('photo');
    prefs!.remove('isGoogle');
  }

  setPrefs() async {
    prefs = await SharedPreferences.getInstance();
    // prefs!.setBool('isLogIn', true);
    isLogin = prefs!.getBool("isLogIn") ?? true;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
      setPrefs();
    });
    // TODO: implement initState
    super.initState();
  }

  Widget bodyProgress() => Stack(
        children: <Widget>[
          // logInPage(),
          Container(
            alignment: AlignmentDirectional.center,
            decoration: const BoxDecoration(
              color: Colors.black54,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 3, color: Colors.grey),
              ),
              width: 300.0,
              height: 200.0,
              alignment: AlignmentDirectional.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Center(
                    child: SizedBox(
                      height: 50.0,
                      width: 50.0,
                      child: CircularProgressIndicator(
                        value: null,
                        strokeWidth: 5.0,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25.0),
                    child: const Center(
                      child: Text(
                        "wait...",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  UserCredential? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Social Media Log In"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: _loading
            ? bodyProgress()
            : (prefs!.getBool("isLogIn") ?? true)
                ? logInPage()
                : detailsOfUser(),
      ),
    );
  }

  Widget logInPage() {
    return Column(
      children: [
        customButton(
            name: 'Sign In With Google',
            tap: () async {
              OAuthCredential credential = await FireBaseAuthHelpper.fireBaseAuthHelpper.signInWithGoogle();
              _onLoading();
              user = await FireBaseAuthHelpper.fireBaseAuthHelpper.firebaseAuth.signInWithCredential(credential);
              addData(email: user!.user!.email.toString(), name: user!.user!.displayName.toString(), photo: user!.user!.photoURL.toString());
              setState(() {
                isGoogle = true;
                prefs!.setBool('isLogIn', false);
                isLogin = prefs!.getBool("isLogIn") ?? false;
              });
            }),
        customButton(
            name: 'Sign In With FaceBook',
            tap: () async {
              user = await FireBaseAuthHelpper.fireBaseAuthHelpper.signInWithFacebook();
              _onLoading();
              addData(email: user!.user!.email.toString(), name: user!.user!.displayName.toString(), photo: user!.user!.photoURL.toString());
              isGoogle = false;
              prefs!.setBool('isLogIn', false);
              isLogin = prefs!.getBool("isLogIn") ?? false;
            }),
      ],
    );
  }

  Widget detailsOfUser() {
    // prefs = SharedPreferences.getInstance() as SharedPreferences?;
    String? email = prefs!.getString('email');
    String? name = prefs!.getString('name');
    String? photo = prefs!.getString('photo');
    bool? isGoogle = prefs!.getBool('isGoogle');
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 3, color: Colors.grey),
            ),
            child: Image.network(
              photo!,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            height: 60,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 3, color: Colors.grey),
            ),
            child: Text(
              (email! == "null") ? "Not Available" : email,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            height: 60,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 3, color: Colors.grey),
            ),
            child: Text(
              name!,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const Spacer(),
          (isGoogle!)
              ? customButton(
                  name: 'Sign Out From Google',
                  tap: () {
                    _onLoading();
                    FireBaseAuthHelpper.fireBaseAuthHelpper.signOut();
                    prefs!.setBool('isLogIn', true);
                    isLogin = prefs!.getBool("isLogIn") ?? true;
                    removeData();
                  })
              : customButton(
                  name: 'Sign Out From FaceBook',
                  tap: () {
                    _onLoading();
                    FireBaseAuthHelpper.fireBaseAuthHelpper.faceBookSignOut();
                    prefs!.setBool('isLogIn', true);
                    isLogin = prefs!.getBool("isLogIn") ?? true;
                    removeData();
                  }),
        ],
      ),
    );
  }
}
