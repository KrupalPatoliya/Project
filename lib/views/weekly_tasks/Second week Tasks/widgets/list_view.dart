import 'package:flutter/material.dart';

class ListViewScreen extends StatefulWidget {
  const ListViewScreen({Key? key}) : super(key: key);

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("ListView"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, i) => Card(
            color: Colors.blue,
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Container(
                margin: const EdgeInsets.only(
                    left: 10, top: 10, bottom: 10, right: 30),
                height: 30,
                width: 400,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.bottomRight,
                    tileMode: TileMode.mirror,
                    stops: const [0.2, 0.5, 0.6, 0.8, 0.9],
                    colors: [
                      Colors.blue.shade700,
                      Colors.blue.shade400,
                      Colors.blue.shade300,
                      Colors.blue.shade200,
                      Colors.white70,
                    ],
                  ),
                ),
              ),
              subtitle: Container(
                margin: const EdgeInsets.only(
                    left: 10, top: 10, bottom: 10, right: 100),
                height: 20,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                 color: Colors.blueAccent.shade700
                ),
              ),
              trailing: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
              ),
              isThreeLine: true,
            ),
          ),
        ),
      ),
    );
  }
}
