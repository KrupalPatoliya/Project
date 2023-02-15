import 'package:flutter/cupertino.dart';
import 'app_theme_model.dart';

class ThemeProvider extends ChangeNotifier {
  AppTheme obj = AppTheme(isDark: false);

  void changeTheme() {
    obj.isDark = !obj.isDark;
    notifyListeners();
  }
}