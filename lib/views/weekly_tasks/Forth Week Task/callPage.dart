import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class CallingPage extends StatefulWidget {
  const CallingPage({Key? key}) : super(key: key);

  @override
  State<CallingPage> createState() => _CallingPageState();
}

class _CallingPageState extends State<CallingPage> {
  final TextEditingController _numberController = TextEditingController();
  late String number;
  GlobalKey<FormState> FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Send Call"),
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
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  if (FormKey.currentState!.validate()) {
                    FormKey.currentState!.save();
                    final Uri callLaunchUri = Uri(
                      scheme: 'tel',
                      path: '+91$number',
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
                    "Call",
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
