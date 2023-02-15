import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_app/views/weekly_tasks/Fifth%20week%20task/play_records.dart';
import 'package:training_app/views/weekly_tasks/Fifth%20week%20task/record_volum_page.dart';

import '../../../helpers/database_helpper/record_db_helpper.dart';
import '../../../models/records.dart';

class RecordListPage extends StatefulWidget {
  const RecordListPage({Key? key}) : super(key: key);

  @override
  State<RecordListPage> createState() => _RecordListPageState();
}

class _RecordListPageState extends State<RecordListPage> {
  List<Records>? directory = [];

  getPath() async {
    directory = (await RecordDataBaseHelpper.dataBaseHelpper.fetchAllData())!;
  }

  @override
  void initState() {
    getPath();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Recorder Page"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RecorderPage(),
            ),
          ).then(
            (value) => setState(() {}),
          );
        },
        child: const Icon(Icons.mic),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        alignment: Alignment.center,
        child: Column(
          children: [
            FutureBuilder(
              future: RecordDataBaseHelpper.dataBaseHelpper.fetchAllData(),
              builder: (context, snapShot) {
                directory = snapShot.data;
                if (snapShot.hasData) {
                  return (directory!.isEmpty)
                      ? const SizedBox(
                          height: 670,
                          child: Center(
                            child: Text(
                              "Not Any Recording",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 670,
                          child: ListView.builder(
                            itemCount: directory!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                color: Colors.blue.shade50,
                                child: ListTile(
                                  onLongPress: () {
                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Delete User'),
                                          content: const Text('Are you sure you want to delete User...'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                RecordDataBaseHelpper.dataBaseHelpper.deleteData(id: directory![index].id!);
                                                setState(() {});
                                                Navigator.of(context).pop();
                                              },
                                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                              child: const Text('Delete', style: TextStyle(color: Colors.white)),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PlayRecordsPage(
                                          id: index,
                                          name: directory![index].path,
                                          allSongs: directory!,
                                        ),
                                      ),
                                    ).then(
                                      (value) => setState(() {}),
                                    );
                                  },
                                  leading: const Image(
                                    image: NetworkImage(
                                      "https://i.pinimg.com/originals/ae/2e/56/ae2e5651b74a00d5d31b8c6453fa3ebb.png",
                                    ),
                                  ),
                                  tileColor: Colors.blue.shade50,
                                  isThreeLine: true,
                                  title: Text(directory![index].path.split("/").last, maxLines: 1, overflow: TextOverflow.ellipsis),
                                  subtitle: const Text("No artist"),
                                ),
                              );
                            },
                          ),
                        );
                } else if (snapShot.hasError) {
                  return Center(
                    child: Text("${snapShot.error}", style: const TextStyle(color: Colors.white), textAlign: TextAlign.center),
                  );
                }else {
                  return const Center(
                  child: CircularProgressIndicator(),
                );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
