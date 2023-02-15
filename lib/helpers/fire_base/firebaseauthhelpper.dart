import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseAuthHelpper {
  FireBaseAuthHelpper._();

  static final FireBaseAuthHelpper fireBaseAuthHelpper = FireBaseAuthHelpper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FacebookAuth faceBookBaseAuth = FacebookAuth.instance;

  Future<String?> anonymousSignIn() async {
    UserCredential userCredential = await firebaseAuth.signInAnonymously();

    User? user = userCredential.user;

    String uid = user!.uid;

    return uid;
  }

  Future<User?> signUp({required String email, required String password, required String name}) async {
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      var k = firebaseAuth.currentUser!.updateDisplayName(name);

      User? user = userCredential.user;
      Fluttertoast.showToast(
          msg: "Log In SuccessFull",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      return user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('No user found for that email.');
        Fluttertoast.showToast(
            msg: "Weak PassWord",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'email-already-in-use') {
        print('Wrong password provided for that user.');
        Fluttertoast.showToast(
            msg: "email-already-in-use",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  Future<User?> signIn({required String email, required String password}) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      Fluttertoast.showToast(
          msg: "Log In SuccessFull",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Fluttertoast.showToast(
            msg: "Email Not Found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Fluttertoast.showToast(
            msg: "Wrong PassWord",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  void changePassword(String password) {
    //Create an instance of the current user.
    User? user = firebaseAuth.currentUser;

    user!.updatePassword(password).then((_) {
      print("Successfully changed password");
      Fluttertoast.showToast(
          msg: "Successfully changed password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: "Password can't be changed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  Future resetPassword({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<OAuthCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    // final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: ['https://mail.google.com/']).signIn();

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    Future<UserCredential> user = firebaseAuth.signInWithCredential(credential);

    return credential;
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    LoginResult loginResult = await faceBookBaseAuth.login(permissions: ["public_profile", "email"]);

    log("================================");
    log("User Id ${loginResult.accessToken!.userId}");
    log("================================");

    // Create a credential from the access token
    OAuthCredential? facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    log("================================");
    log(facebookAuthCredential.toString());
    log("================================");

    // Once signed in, return the UserCredential
    return firebaseAuth.signInWithCredential(facebookAuthCredential);
  }

  faceBookSignOut() async {
    await faceBookBaseAuth.logOut();
    await firebaseAuth.signOut();
    log("================================");
    log("Sign Out SuccessFully");
    log("================================");
  }

  Future<void> signOut() async {
    await googleSignIn.signOut();
    await firebaseAuth.signOut();
    log("================================");
    log("Sign Out SuccessFully");
    log("================================");
  }
}
