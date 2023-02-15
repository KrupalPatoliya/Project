import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePickerPage extends StatefulWidget {
  const DatePickerPage({Key? key}) : super(key: key);

  @override
  State<DatePickerPage> createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  DateTime selectedDate = DateTime.now();
  DateTime selecteiosdDate = DateTime.now();

  _selectDate(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      helpText: 'Select Date',
      cancelText: 'CANCEL',
      confirmText: 'OK',
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  _selectIosDate(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != null && picked != selecteiosdDate)
                  setState(() {
                    selecteiosdDate = picked;
                  });
              },
              initialDateTime: selecteiosdDate,
              minimumYear: 2000,
              maximumYear: 2025,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text("Date Picker"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              selectedDate.toString().split(' ')[0],
              style: const TextStyle(
                fontSize: 18,
                  color: Colors.white
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                _selectDate(context);
              },
              child: const Text(
                "Android Date Picker",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              selecteiosdDate.toString().split(' ')[0],
              style: const TextStyle(
                fontSize: 18,
                  color: Colors.white
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                _selectIosDate(context);
              },
              child: const Text(
                "IOS Date Picker",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
