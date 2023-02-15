import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_app/helpers/fire_base/fireBaseCloudHelpper.dart';
import 'package:training_app/models/todos.dart';
import 'package:training_app/views/weekly_tasks/Nineth%20Week%20Task/cloud_fire_store/edit_data_page.dart';
import 'package:training_app/views/weekly_tasks/Nineth%20Week%20Task/cloud_fire_store/view_screen.dart';

class FireStoreDatabaseScreen extends StatefulWidget {
  const FireStoreDatabaseScreen({Key? key}) : super(key: key);

  @override
  State<FireStoreDatabaseScreen> createState() => _FireStoreDatabaseScreenState();
}

class _FireStoreDatabaseScreenState extends State<FireStoreDatabaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("FireStore Database"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ShowDataPage(),
            ),
          ).then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder(
                stream: FireBaseCloudHelpper.fireBaseCloudHelpper.fetchAllData(),
                builder: (context, AsyncSnapshot snapShot) {
                  if (snapShot.hasError) {
                    return Center(
                      child: Text(snapShot.error.toString()),
                    );
                  } else if (snapShot.hasData) {
                    List data = snapShot.data!.docs;

                    List<ToDos> users = FireBaseCloudHelpper.fireBaseCloudHelpper.getAllData(data: data);

                    print(users);

                    return (users.isEmpty)
                        ? const Center(
                            child: Text(
                              "Data Not Found",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container(
                            height: 700,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ListView.builder(
                                itemCount: users.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Colors.white10,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Task Id :- ${users[index].id}",
                                                style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                              ),
                                              const Spacer(),
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => EditDataPage(
                                                        toDos: users[index],
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
                                                                FireBaseCloudHelpper.fireBaseCloudHelpper.deleteUser(id: users[index].id);
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
                                          Text(
                                            "Task Title :- ${users[index].task_title}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Task Description :- ${users[index].task_description}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Create Date :- ${users[index].createDate}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Done Date :- ${users[index].doneDate}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Status :- ${users[index].status}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
