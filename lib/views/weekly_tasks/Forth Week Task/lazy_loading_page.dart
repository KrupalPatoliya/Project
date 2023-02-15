import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:training_app/helpers/api_helpper/lazy_loading_api_helpper.dart';
import 'package:training_app/models/userdata.dart';
import 'package:http/http.dart' as http;

class LazyLoadingPage extends StatefulWidget {
  const LazyLoadingPage({Key? key}) : super(key: key);

  @override
  State<LazyLoadingPage> createState() => _LazyLoadingPageState();
}

class _LazyLoadingPageState extends State<LazyLoadingPage> {
  ScrollController controller = ScrollController();
  int id = 0;
  List<UserData>? data;
  bool isLoading = false;
  List users = [];

  void _getMoreData(int index) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      var url = "https://randomuser.me/api/?page=$index&results=20&seed=abc";
      final response = await http.get(Uri.parse(url));
      Map decodedData = jsonDecode(response.body);

      List data = decodedData['results'];

      List tList = [];
      for (int i = 0; i < data.length; i++) {
        tList.add(data[i]);
      }
      setState(() {
        isLoading = false;
        users.addAll(tList);
        id++;
      });
    }
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getMoreData(id);
    });
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        _getMoreData(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Lazy Loading"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 660,
              child: ListView.builder(
                itemCount: users.length + 1,
                controller: controller,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                itemBuilder: (BuildContext context, int index) {
                  if (index == users.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      child: Center(
                        child: Opacity(
                          opacity: isLoading ? 1 : 0,
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                    );
                  } else {
                    return Card(
                      color: Colors.grey.shade400,
                      child: ListTile(
                        isThreeLine: true,
                        leading: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                            users[index]['picture']['large'],
                          ),
                        ),
                        title: Text((users[index]['name']['first'])),
                        subtitle: Text((users[index]['email'])),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
