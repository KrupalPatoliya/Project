import 'package:flutter/material.dart';

class FlutterSliversPage extends StatefulWidget {
  const FlutterSliversPage({Key? key}) : super(key: key);

  @override
  State<FlutterSliversPage> createState() => _FlutterSliversPageState();
}

class _FlutterSliversPageState extends State<FlutterSliversPage> {
  final bool _pinned = true;
  final bool _snap = false;
  final bool _floating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 200,
            // elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('SliverAppBar'),
              centerTitle: true,
              background: Image.asset(
                "assets/images4.jpeg",
                fit: BoxFit.fill,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade700, Colors.deepPurple.shade600],
                    ),
                    border: Border.all(
                      color: Colors.blue.shade900,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
