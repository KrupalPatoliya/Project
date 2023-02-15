import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training_app/helpers/api_helpper/api_helpper.dart';
import 'package:training_app/models/api_model.dart';
import 'package:training_app/views/weekly_tasks/Third%20week%20task/add_api_data.dart';
import 'package:training_app/views/weekly_tasks/Third%20week%20task/update_api_data.dart';

class ApiCallingPage extends StatefulWidget {
  const ApiCallingPage({Key? key}) : super(key: key);

  @override
  State<ApiCallingPage> createState() => _ApiCallingPageState();
}

class _ApiCallingPageState extends State<ApiCallingPage> with WidgetsBindingObserver {
  int value = 0;

  getUser() async {
    UserModelList? userModelList = await ApiHelpper.apiHelpper.fetchingMultipleData();
    value++;
    print(value);

    return userModelList;
  }

  // updateUI() {
  //   if (mounted) setState(() {});
  // }
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
    print("initState");
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      log("resumed");
    } else if (state == AppLifecycleState.detached) {
      log("detached");
    } else if (state == AppLifecycleState.paused) {
      log("paused");
    } else if (state == AppLifecycleState.inactive) {
      log("inactive");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("API Calling"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddApiDataPage(),
            ),
          ).then((value) => setState(() {
                getUser();
              }));
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        backgroundColor: Colors.transparent,
        color: Colors.blue,
        onRefresh: () async {
          setState(() {
            getUser();
          });
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: FutureBuilder(
            future: getUser(),
            builder: (context, AsyncSnapshot snapshot) {
              print(snapshot.data.toString());
              // if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                UserModelList? res = snapshot.data;
                print(res!.data!.first.name);

                // ignore: unnecessary_null_comparison
                return (res == null)
                    ? const Center(
                        child: Text(
                          "Data Not Exist",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: res.data!.length,
                        itemBuilder: (context, i) {
                          return Card(
                            color: Colors.grey.shade900,
                            child: ListTile(
                              isThreeLine: true,
                              title: Text(
                                "${res.data![i].name}",
                                style: const TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              subtitle: Text(
                                "${res.data![i].email}",
                                // maxLines: 1,
                                // overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              leading: ClipOval(
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: (res.data![i].profilePic == "")
                                      ? const Icon(
                                          Icons.perm_identity_outlined,
                                          color: Colors.grey,
                                          size: 40,
                                        )
                                      : Image.network("${res.data![i].profilePic}", fit: BoxFit.cover),
                                ),
                              ),
                              trailing: SizedBox(
                                width: 100,
                                child: Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UpdateApiDataPage(
                                            employee: res.data?[i],
                                          ),
                                        ),
                                      ).then((value) => setState(() {}));

                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.edit, color: Colors.blue),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return CupertinoAlertDialog(
                                            title: const Text('Delete User'),
                                            content: const Text('Are you sure you want to delete User...'),
                                            actions: <Widget>[
                                              CupertinoDialogAction(
                                                child: const Text('Cancel'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              CupertinoDialogAction(
                                                child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                                onPressed: () {
                                                  ApiHelpper.apiHelpper.deleteSingleData(id: res.data![i].userId);
                                                  setState(() {});
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                                  ),
                                ]),
                              ),
                            ),
                          );
                        },
                      );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "${snapshot.error}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              // } else if (snapshot.connectionState == ConnectionState.waiting) {
              //   return const Center(
              //       child: Text(
              //     "Waiting..",
              //     style: TextStyle(color: Colors.white, fontSize: 18),
              //   ));
              // } else if (snapshot.connectionState == ConnectionState.active) {
              //   return const Center(
              //       child: Text(
              //     "Active..",
              //     style: TextStyle(color: Colors.white, fontSize: 18),
              //   ));
              // } else {
              //   return const Center(child: CircularProgressIndicator());
              // }
            },
          ),
        ),
      ),
    );
  }
}
