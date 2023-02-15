import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> with SingleTickerProviderStateMixin {
  AnimationController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..forward();
    controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(196, 135, 198, 1),
        elevation: 0,
        title: const Text("Log In"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SlideTransition(
              position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(controller!),
              child: SizedBox(
                height: 350,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: -40,
                      height: 350,
                      width: width,
                      child: Container(
                        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background.png'), fit: BoxFit.fill)),
                      ),
                    ),
                    Positioned(
                      height: 350,
                      width: width + 20,
                      child: Container(
                        decoration:
                            const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background-2.png'), fit: BoxFit.fill)),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SlideTransition(
                    position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(controller!),
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SlideTransition(
                    position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(controller!),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white, boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(196, 135, 198, 0.3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        )
                      ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey.shade200),
                              ),
                            ),
                            child: const TextField(
                              decoration: InputDecoration(border: InputBorder.none, hintText: "Username", hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: const TextField(
                              decoration: InputDecoration(border: InputBorder.none, hintText: "Password", hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TweenAnimationBuilder(
                    tween: Tween<double>(end: 1, begin: 2),
                    duration: const Duration(seconds: 2),
                    builder: (context, value, widget) {
                      return Transform.scale(
                        scale: value,
                        child: const Center(
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Color.fromRGBO(196, 135, 198, 1)),
                          ),
                        ),
                      );
                    },
                  ),
                  // const Center(
                  //     child: Text(
                  //   "Forgot Password?",
                  //   style: TextStyle(color: Color.fromRGBO(196, 135, 198, 1)),
                  // )),
                  const SizedBox(
                    height: 20,
                  ),
                  SlideTransition(
                    position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(controller!),
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 60),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color.fromRGBO(49, 39, 79, 1),
                      ),
                      child: const Center(
                        child: Text(
                          "Log in",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TweenAnimationBuilder(
                    tween: Tween<double>(end: 1, begin: 0),
                    duration: const Duration(seconds: 2),
                    builder: (context, value, widget) {
                      return Transform.scale(
                        scale: value,
                        child: const Center(
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                              color: Color.fromRGBO(49, 39, 79, 0.6),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // const Center(
                  //     child: Text(
                  //   "Create Account",
                  //   style: TextStyle(color: Color.fromRGBO(49, 39, 79, 0.6)),
                  // )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
