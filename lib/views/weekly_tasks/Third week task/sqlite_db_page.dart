import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_app/helpers/database_helpper/database_helpper_class.dart';
import 'package:training_app/models/employee.dart';
import 'package:training_app/views/weekly_tasks/Third%20week%20task/updateData.dart';

import '../../../utils/app_routes.dart';

class SqliteDBPage extends StatefulWidget {
  const SqliteDBPage({Key? key}) : super(key: key);

  @override
  State<SqliteDBPage> createState() => _SqliteDBPageState();
}

class _SqliteDBPageState extends State<SqliteDBPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DataBaseHelpper.dataBaseHelpper.initDB();
    DataBaseHelpper.dataBaseHelpper.fetchAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("SqLite DB"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes().insertDataScreen).then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
          future: DataBaseHelpper.dataBaseHelpper.fetchAllData(),
          builder: (BuildContext context, AsyncSnapshot<List<Employee>?> snapshot) {
            if (snapshot.hasData) {
              List<Employee>? data = snapshot.data!;
              return (data.isEmpty)
                  ? const Center(
                      child: Text(
                        "data Not Exist",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, i) {
                            return Card(
                              color: Colors.grey.shade900,
                              child: ListTile(
                                isThreeLine: true,
                                leading: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(image: MemoryImage(data[i].image), fit: BoxFit.cover),
                                  ),
                                ),
                                title: Text(
                                  "Name :- ${data[i].name}",
                                  style: const TextStyle(color: Colors.white, fontSize: 18),
                                ),
                                subtitle: Text(
                                  "Age :- ${data[i].age}\nSalary :- ${data[i].salary}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                trailing: SizedBox(
                                  width: 100,
                                  child: Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => UpdateData(
                                              employee: data[i],
                                            ),
                                          ),
                                        ).then((value) => setState(() {}));
                                      },
                                      icon: const Icon(Icons.edit, color: Colors.blue),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog<void>(
                                          context: context,
                                          barrierDismissible: false, // user must tap button!
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
                                                  onPressed: () async {
                                                    await DataBaseHelpper.dataBaseHelpper.deleteData(id: data[i].id);
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
                          }),
                    );
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(snapshot.error.toString(), style: const TextStyle(color: Colors.white)),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
