import 'package:flutter/material.dart';
import 'package:razvoj_sofvera/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  bool isDarkMode = false;
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }

    isDarkMode = !isDarkMode;
    notifyListeners();
  }

  void changeTheme() {}
}
