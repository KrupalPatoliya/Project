import 'package:flutter/material.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        backgroundColor: Theme
            .of(context)
            .backgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Tab Bar"),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Theme
              .of(context)
              .backgroundColor,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), child: Text("Home")),
              Tab(icon: Icon(Icons.settings), child: Text("Settings")),
              Tab(
                  icon: Icon(Icons.network_check_outlined),
                  child: Text("Network")),
            ],
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: TabBarView(
            children: [
              Container(
                alignment: Alignment.center,
                child: const Icon(Icons.home,color: Colors.blue,size: 40),
              ),
              Container(
                alignment: Alignment.center,
                child: const Icon(Icons.settings,color: Colors.blue,size: 40),
              ),
              Container(
                alignment: Alignment.center,
                child: const Icon(Icons.network_check_outlined,color: Colors.blue,size: 40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
