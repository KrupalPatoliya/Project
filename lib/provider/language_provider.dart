import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale locale = const Locale("en");

  void changeLanguage({required String code}) {
    if(code == locale.languageCode){
      locale = Locale(code);
      return;
    }
    locale = Locale(code);
    notifyListeners();
  }
}
