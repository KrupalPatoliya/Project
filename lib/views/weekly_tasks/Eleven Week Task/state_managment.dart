import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training_app/get_controller/getx_counter.dart';
import 'package:training_app/get_controller/lanuage.dart';

class StateManagement extends StatefulWidget {
  const StateManagement({Key? key}) : super(key: key);

  @override
  State<StateManagement> createState() => _StateManagementState();
}

class _StateManagementState extends State<StateManagement> {
  CounterController counterController = Get.put(CounterController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.changeTheme(ThemeData.light());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    counterController.count.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Languages(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      themeMode: Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("State Management"),
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                  print(Get.isDarkMode);
                },
                child: const Text('Change Theme'),
              ),
              const SizedBox(height: 20),
              Obx(
                () => Text(
                  "${counterController.count.value}",
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    heroTag: "1",
                    onPressed: () {
                      counterController.increment();
                    },
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(width: 50),
                  FloatingActionButton(
                    heroTag: "2",
                    onPressed: () {
                      counterController.decrement();
                    },
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.snackbar(
                    "SnackBar",
                    "Getx SnackBar",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                child: const Text("Show SnackBar"),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: 'GetX Alert',
                    middleText: 'Simple GetX alert',
                    textConfirm: 'Okay',
                    confirmTextColor: Colors.white,
                    textCancel: 'Cancel',
                    onCancel: () {
                      Navigator.of(context).pop();
                    },
                    onConfirm: () {
                      Get.snackbar(
                        "SnackBar",
                        "Getx SnackBar",
                        snackPosition: SnackPosition.TOP,
                      );
                      Navigator.of(context).pop();
                    },
                  );
                },
                child: const Text("Alert Dialog"),
              ),
              const SizedBox(height: 20),
              Text(
                'greeting'.tr,
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Get.updateLocale(const Locale('en', "US")),
                child: const Text('English'),
              ),
              ElevatedButton(
                onPressed: () => Get.updateLocale(const Locale('ko', 'KR')),
                child: const Text('Korean'),
              ),
              ElevatedButton(
                onPressed: () => Get.updateLocale(const Locale('ja', "JP")),
                child: const Text('Japan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
