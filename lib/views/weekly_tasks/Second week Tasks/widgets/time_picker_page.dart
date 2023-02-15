import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimePickerPage extends StatefulWidget {
  const TimePickerPage({Key? key}) : super(key: key);

  @override
  State<TimePickerPage> createState() => _TimePickerPageState();
}

class _TimePickerPageState extends State<TimePickerPage> {
  TimeOfDay timeOfDay = TimeOfDay.now();
  String? _hour, _minute, _time;

  // late String dateTime;

  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay d =
      TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = '$_hour : $_minute';
      });
    }
  }

  DateTime date = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedTime = TimeOfDay.now();
    _time =
        "${selectedTime.hour.toString()} : ${selectedTime.minute.toString()}";
    d = TimeOfDay(hour: selectedTime.hour, minute: selectedTime.minute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text("Time Picker"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              "$_time  ${(selectedTime.period.name)}",
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                _selectTime(context);
              },
              child: const Text(
                "Android Time Picker",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "${date.toString().split(' ')[1].split('.')[0]} ${d.period.name}",
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: 250,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          initialDateTime:
                              DateTime(date.year, date.month, date.day, 12, 12),
                          onDateTimeChanged: (DateTime newDateTime) {
                            date = newDateTime;
                            setState(() {
                              d = TimeOfDay(
                                  hour: newDateTime.hour,
                                  minute: newDateTime.minute);
                            });
                          },
                        ),
                      );
                    });
              },
              child: const Text(
                "IOS Time Picker",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
