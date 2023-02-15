import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/provider/theme_Provider.dart';
import 'package:training_app/views/weekly_tasks/widgets/custombutton.dart';

import '../../helpers/fire_base/fire_base_dynamic_link_create.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getData() async {
    await FireBaseDynamicLinkCreating.fireBaseDynamicLinkCreating.getDynamicLink(context: context);
  }


  

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text("Training Work"),
        elevation: 0,
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Provider.of<ThemeProvider>(context, listen: false).changeTheme();
        //     },
        //     icon: const Icon(Icons.light_mode),
        //   ),
        // ],
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 20),
        alignment: Alignment.center,
        child: ListView.builder(
          itemCount: 12,
          itemBuilder: (context, i) {
            return customButton(
              name: 'Week ${i + 1}',
              tap: () {
                Navigator.of(context).pushNamed('Week${i + 1}');
              },
            );
          },
        ),
      ),
    );
  }
}
