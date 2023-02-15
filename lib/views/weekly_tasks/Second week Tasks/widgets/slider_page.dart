import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({Key? key}) : super(key: key);

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _value = 0;
  RangeValues _currentRangeValues = const RangeValues(0, 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text("Slider"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${_value.toInt()}",
                style: const TextStyle(color: Colors.white, fontSize: 20)),
            const SizedBox(
              height: 20,
            ),
            Slider(
              min: 0,
              max: 50,
              value: _value,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
                "Start :- ${_currentRangeValues.start.toInt()} End :- ${_currentRangeValues.end.toInt()}",
                style: const TextStyle(color: Colors.white, fontSize: 20)),
            const SizedBox(
              height: 20,
            ),
            RangeSlider(
              values: _currentRangeValues,
              min: 0,
              max: 100,
              divisions: 10,
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
              },
            ),
            const SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
