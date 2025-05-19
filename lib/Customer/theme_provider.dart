// theme_provider.dart
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void setLightMode() {
    _themeMode = ThemeMode.light;
    notifyListeners();
  }

  void setDarkMode() {
    _themeMode = ThemeMode.dark;
    notifyListeners();
  }
}
