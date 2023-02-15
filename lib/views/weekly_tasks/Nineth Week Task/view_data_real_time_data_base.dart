import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_app/helpers/fire_base/real_time_data_base_helper.dart';
import 'package:training_app/models/real_time_employee.dart';
import 'package:training_app/views/weekly_tasks/Nineth%20Week%20Task/edit_data_real_time.dart';

import '../../../helpers/fire_base/fire_base_storage.dart';

class RealTimeDataBaseViewDataPage extends StatefulWidget {
  const RealTimeDataBaseViewDataPage({Key? key}) : super(key: key);

  @override
  State<RealTimeDataBaseViewDataPage> createState() => _RealTimeDataBaseViewDataPageState();
}

class _RealTimeDataBaseViewDataPageState extends State<RealTimeDataBaseViewDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("RealTime Database"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              height: 710,
              child: FirebaseAnimatedList(
                query: RealTimeDataBaseHelper.realTimeDataBaseHelper.getData(),
                defaultChild: const Center(
                  child: CircularProgressIndicator(),
                ),
                itemBuilder: (context, snapshot, animation, index) {
                  var data = snapshot.value as Map;
                  if (snapshot.exists == true) {
                    EmployeeDataBase user = EmployeeDataBase(
                      pic: data['pic'] ?? "",
                      id: data['id'],
                      name: data['name'],
                      email: data['email'],
                      salary: data['salary'],
                      number: data['number'],
                      gender: data['gender'],
                      designation: data['designation'],
                    );
                    return (user != null)
                        ? Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(color: Colors.black, width: 2),
                                        ),
                                        child: (user.pic != "")
                                            ? Image.network(
                                                user.pic,
                                                fit: BoxFit.cover,
                                              )
                                            : const Icon(Icons.people),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => EditDataRealTimePage(
                                                user: user,
                                              ),
                                            ),
                                          ).then((value) => setState(() {}));
                                        },
                                        icon: const Icon(
                                          Icons.edit_rounded,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
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
                                                        String file = user.pic.split("/").last.split("?").first;

                                                        FireBaseStorageHelpper.fireBaseStorageHelpper.removeImage(file: file);
                                                        RealTimeDataBaseHelper.realTimeDataBaseHelper.deleteData(id: user.id);
                                                        // ApiHelpper.apiHelpper.deleteSingleData(id: res.data![i].userId);
                                                        setState(() {});
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(Icons.people, color: Colors.deepPurple),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Name :- ${user.name}",
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(Icons.mail, color: Colors.deepPurple),
                                      const SizedBox(width: 10),
                                      Text(
                                        "email :- ${user.email}",
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(Icons.g_mobiledata_outlined, color: Colors.deepPurple),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Gender :- ${user.gender}",
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(Icons.monetization_on, color: Colors.deepPurple),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Salary :- ${user.salary}",
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(Icons.call, color: Colors.deepPurple),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Number :- ${user.number}",
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(Icons.badge, color: Colors.deepPurple),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        width: 298,
                                        child: Text(
                                          "Designation :- ${user.designation}",
                                          overflow: TextOverflow.fade,
                                          style: const TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(Icons.key, color: Colors.deepPurple),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Id :- ${user.id}",
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const Center(
                            child: Text(
                              "Data Not Found",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          );
                  } else if (snapshot.exists == false) {
                    return const Center(
                      child: Text(
                        "Data Not Found",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
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
}
