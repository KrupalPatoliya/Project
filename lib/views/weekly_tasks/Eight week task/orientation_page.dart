import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrientationPage extends StatefulWidget {
  const OrientationPage({Key? key}) : super(key: key);

  @override
  State<OrientationPage> createState() => _OrientationPageState();
}

class _OrientationPageState extends State<OrientationPage> {
  bool isTrue = false;

  callInDisPose() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    callInDisPose();
    super.deactivate();
  }

  @override
  void dispose() {
    callInDisPose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("ActionSheet And PopOver"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () async {
            if (isTrue) {
              await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
              isTrue = false;
            } else {
              await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
              isTrue = true;
            }

            setState(() {});
          },
          child: const Icon(CupertinoIcons.arrow_2_circlepath),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: OrientationBuilder(
          builder: (context, orientation) {
            return (orientation == Orientation.portrait)
                ? Column(
                    children: [
                      Expanded(
                        child: Container(
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            image: const DecorationImage(
                              image: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnTo6TDNKkt5BW4MzI3YMaB9fEap7PneWulj2oE2JSC4tYaHEkN5q86ybgF7v8HGnlxD4&usqp=CAU",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        // flex: 1,
                        child: GridView.builder(
                          itemCount: 10,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, i) => Container(
                            height: 300,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade800,
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/bird.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            image: const DecorationImage(
                              image: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnTo6TDNKkt5BW4MzI3YMaB9fEap7PneWulj2oE2JSC4tYaHEkN5q86ybgF7v8HGnlxD4&usqp=CAU",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        // flex: 1,
                        child: GridView.builder(
                          itemCount: 10,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, i) => Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade800,
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/bird.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
