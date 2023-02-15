import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import '../../../helpers/fire_base/firebaseauthhelpper.dart';

class SendEmailPage extends StatefulWidget {
  const SendEmailPage({Key? key}) : super(key: key);

  @override
  State<SendEmailPage> createState() => _SendEmailPageState();
}

class _SendEmailPageState extends State<SendEmailPage> {
  TextEditingController _numberController = TextEditingController();
  String? number;
  TextEditingController _messageController = TextEditingController();
  String? message;
  TextEditingController _emailController = TextEditingController();
  String? email;
  GlobalKey<FormState> FormKey = GlobalKey<FormState>();

  List<String>? files = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Send Message"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Form(
          key: FormKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white),
                controller: _emailController,
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
                      color: Colors.white70,
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
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.white),
                controller: _numberController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter your Subject...";
                  }
                  return null;
                },
                onSaved: (val) {
                  number = val!;
                },
                decoration: InputDecoration(
                  label: const Text(
                    "Subject",
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
                  hintText: "Enter your Subject here",
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
              const SizedBox(height: 20),
              TextFormField(
                minLines: 1,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(color: Colors.white),
                controller: _messageController,
                onSaved: (val) {
                  message = val!;
                },
                decoration: InputDecoration(
                  label: const Text(
                    "Message",
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
                  hintText: "Enter your Message here",
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
              const SizedBox(height: 30),
              // ignore: unnecessary_null_comparison
              GestureDetector(
                onTap: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

                  if (result != null) {
                    result.files.map((e) => files?.add(e.path.toString())).toList();
                    setState(() {});
                  } else {}
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 3, color: Colors.grey),
                  ),
                  child: (files!.isEmpty)
                      ? const Text("Not File Attach", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold))
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: files?.length,
                          itemBuilder: (context, i) =>
                              (files![i].split('.').last == 'jpg' || files![i].split('.').last == 'jpeg' || files![i].split('.').last == 'png')
                                  ? Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipOval(
                                            child: Image.file(
                                              File(files![i]),
                                              fit: BoxFit.cover,
                                              height: 70,
                                              width: 70,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: -7,
                                          top: 7,
                                          bottom: 60,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                files!.remove(files![i]);
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.remove_circle,
                                              color: Colors.redAccent,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipOval(
                                            child: Container(
                                              height: 70,
                                              width: 70,
                                              color: Colors.white70,
                                              child: Center(
                                                child: Text(
                                                  ".${files![i].split('.').last}",
                                                  style: const TextStyle(color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: -7,
                                          top: 7,
                                          bottom: 60,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                files!.remove(files![i]);
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.remove_circle,
                                              color: Colors.red,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                        ),
                ),
              ),
              const Spacer(),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  if (FormKey.currentState!.validate()) {
                    FormKey.currentState!.save();

                    FireBaseAuthHelpper.fireBaseAuthHelpper.signOut();
                    Email email1 = Email(
                      body: _messageController.text,
                      subject: _numberController.text,
                      recipients: [_emailController.text],
                      attachmentPaths: files,
                      isHTML: false,
                    );

                    print(email1.recipients);

                    await FlutterEmailSender.send(email1);
                  }
                },
                child: Container(
                  height: 60,
                  width: 500,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue.shade800),
                  child: const Text(
                    "Send Email",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  if (FormKey.currentState!.validate()) {
                    FormKey.currentState!.save();
                    OAuthCredential credential = await FireBaseAuthHelpper.fireBaseAuthHelpper.signInWithGoogle();
                    print('Access Token ${credential.accessToken}');

                    UserCredential userCredential = await FireBaseAuthHelpper.fireBaseAuthHelpper.firebaseAuth.signInWithCredential(credential);

                    print('Access Token ${credential}');
                    print('Access Token ${userCredential.additionalUserInfo!.profile!['email']}');

                    String? email = userCredential.additionalUserInfo!.profile!['email'];
                    String? token = credential.accessToken;

                    final smtpServer = gmailSaslXoauth2(email!, token!);

                    final message = Message()
                      ..from = Address(email, token)
                      ..recipients.add(_emailController.text)
                      ..subject = _numberController.text
                      ..text = _numberController.text
                      ..attachments = files!.map((e) => FileAttachment(File(e))).toList();

                    try {
                      send(message, smtpServer).then(
                        (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Messege sent SuccessFully....."),
                            ),
                          );
                          FireBaseAuthHelpper.fireBaseAuthHelpper.signOut();
                        },
                      );
                    } on MailerException catch (e) {
                      print('send Email :- $e');
                    }
                  }
                  FireBaseAuthHelpper.fireBaseAuthHelpper.signOut();
                },
                child: Container(
                  height: 60,
                  width: 500,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue.shade800),
                  child: const Text(
                    "Send Email in App",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
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
