import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  int count = 0;

  increment() {
    count++;
    notifyListeners();
  }

  decrement() {
    if (count == 0) {
    } else {
      count--;
      notifyListeners();
    }
  }
}
