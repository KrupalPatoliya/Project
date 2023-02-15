import 'package:flutter/material.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _selectedIndex = 0;

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Bottom Navigation Bar"),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          onTap: (val) {
            setState(() {
              _selectedIndex = val;
              pageController.animateToPage(val,
                  duration: const Duration(microseconds: 100),
                  curve: Curves.ease);
            });
          },
          backgroundColor: Theme.of(context).backgroundColor,
          selectedItemColor: Colors.blue,
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.white,
        ),
        body: PageView(
          onPageChanged: (val) {
            setState(() {
              _selectedIndex = val;
            });
          },
          controller: pageController,
          children: const [
            Center(
              child: Text(
                "Home",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            Center(
              child: Text(
                "Business",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            Center(
              child: Text(
                "Settings",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
    );
  }
}
