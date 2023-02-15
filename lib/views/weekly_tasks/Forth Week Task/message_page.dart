import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageSendPage extends StatefulWidget {
  const MessageSendPage({Key? key}) : super(key: key);

  @override
  State<MessageSendPage> createState() => _MessageSendPageState();
}

class _MessageSendPageState extends State<MessageSendPage> {
  final TextEditingController _numberController = TextEditingController();
  late String number;
  final TextEditingController _messageController = TextEditingController();
  late String message;
  GlobalKey<FormState> FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Send Email"),
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
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.white),
                controller: _numberController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter your Number...";
                  } else if (val.length != 10) {
                    return "Enter your Number of 10th digits..";
                  }
                  return null;
                },
                onSaved: (val) {
                  number = val!;
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
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.white),
                controller: _messageController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter your Message ...";
                  }
                  return null;
                },
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
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  if (FormKey.currentState!.validate()) {
                    FormKey.currentState!.save();
                    final Uri callLaunchUri = Uri(
                      scheme: 'sms',
                      path: '+91$number',
                      queryParameters: <String, String>{
                        'body': Uri.encodeComponent(message),
                      },
                    );

                    launchUrl(callLaunchUri);
                  }
                },
                child: Container(
                  height: 60,
                  width: 500,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue.shade800),
                  child: const Text(
                    "Send Message",
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
