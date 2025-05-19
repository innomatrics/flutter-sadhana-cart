import 'package:flutter/cupertino.dart';

class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void changeLanguage(String languageCode) {
    _locale = Locale(languageCode);
    notifyListeners(); // This is crucial for UI updates
  }
}