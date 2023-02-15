import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:training_app/helpers/fire_base/fire_base_dynamic_link_create.dart';

class DynamicLinksScreen extends StatefulWidget {
  const DynamicLinksScreen({Key? key}) : super(key: key);

  @override
  State<DynamicLinksScreen> createState() => _DynamicLinksScreenState();
}

class _DynamicLinksScreenState extends State<DynamicLinksScreen> {
  String appLink = "";
  String pageLink = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Dynamic Links"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [

            const SizedBox(height: 20),
            (appLink.isEmpty)
                ? const SizedBox()
                : Column(
                    children: [
                      Text(
                        appLink,
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: appLink)).then((value) {
                            Fluttertoast.showToast(
                                msg: "Link Copy", toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
                          });
                        },
                        icon: const Icon(Icons.copy, color: Colors.white),
                      ),
                    ],
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                appLink = await FireBaseDynamicLinkCreating.fireBaseDynamicLinkCreating.createLink();
                setState(() {});
              },
              child: const Text("Create const Link"),
            ),
            const SizedBox(height: 20),
            (pageLink.isEmpty)
                ? const SizedBox()
                : Column(
                    children: [
                      Text(
                        pageLink,
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: pageLink)).then((value) {
                            Fluttertoast.showToast(
                                msg: "Link Copy", toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.grey, gravity: ToastGravity.BOTTOM);
                          });
                        },
                        icon: const Icon(Icons.copy, color: Colors.white),
                      ),
                    ],
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                pageLink = await FireBaseDynamicLinkCreating.fireBaseDynamicLinkCreating.createPageLink();
                setState(() {});
              },
              child: const Text("Create Page Link"),
            ),
          ],
        ),
      ),
    );
  }
}
