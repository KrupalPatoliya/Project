import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:training_app/views/weekly_tasks/Eleven%20Week%20Task/edit_file.dart';

class ViewFileLocallyScreen extends StatefulWidget {
  const ViewFileLocallyScreen({Key? key}) : super(key: key);

  @override
  State<ViewFileLocallyScreen> createState() => _ViewFileLocallyScreenState();
}

class _ViewFileLocallyScreenState extends State<ViewFileLocallyScreen> {
  List<FileSystemEntity>? allFiles;

  pickFile() async {
    final directory = (await getExternalStorageDirectories(type: StorageDirectory.downloads))!.first;

    allFiles = directory.listSync();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pickFile();
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("View File"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            SizedBox(
              height: 690,
              child: (allFiles!.isEmpty)
                  ? Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Not Any File ....",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  : ListView.builder(
                      itemCount: allFiles!.length,
                      itemBuilder: (context, index) {
                        File file = File(allFiles![index].path);
                        return Card(
                          color: Colors.white12,
                          child: ListTile(
                            title: Text(allFiles![index].toString().split('/').last.split('\'').first, style: const TextStyle(color: Colors.white)),
                            subtitle: Text(file.readAsStringSync(), style: const TextStyle(color: Colors.grey)),
                            isThreeLine: true,
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditFileLocallyPage(
                                            file: File(allFiles![index].path),
                                          ),
                                        ),
                                      ).then((value) {
                                        setState(() {
                                          pickFile();
                                        });
                                      });
                                    },
                                    icon: const Icon(Icons.edit),
                                    color: Colors.blue,
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
                                                    File file2 = File(allFiles![index].path);
                                                    file2.delete();
                                                    setState(() {
                                                      pickFile();
                                                    });

                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
