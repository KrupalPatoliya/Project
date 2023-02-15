import 'package:flutter/material.dart';
import 'package:training_app/utils/app_routes.dart';
import 'package:training_app/views/weekly_tasks/widgets/custombutton.dart';

class AllWidgets extends StatefulWidget {
  const AllWidgets({Key? key}) : super(key: key);

  @override
  State<AllWidgets> createState() => _AllWidgetsState();
}

class _AllWidgetsState extends State<AllWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Widgets"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              customButton(
                  name: "Image",
                  tap: () {
                    Navigator.of(context).pushNamed(AppRoutes().imageScreen);
                  }),
              customButton(
                  name: "DropdownButton",
                  tap: () {
                    Navigator.of(context)
                        .pushNamed(AppRoutes().dropDownButtonScreen);
                  }),
              customButton(name: "PopupMenuButton", tap: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes().popUpMenuScreen);
              }),
              customButton(name: "ListView", tap: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes().listViewScreen);
              }),
              customButton(name: "GridView", tap: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes().gridViewScreen);
              }),
              customButton(name: "Stack", tap: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes().stackScreen);
              }),
              customButton(name: "Date Pickers", tap: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes().datePickerScreen);
              }),
              customButton(name: "Time Pickers", tap: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes().timePickerScreen);
              }),
              customButton(name: "AlertDialog", tap: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes().alertDialogScreen);
              }),
              customButton(name: "Snack Bar", tap: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes().snackBarScreen);
              }),
              customButton(name: "Slider", tap: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes().sliderScreen);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
