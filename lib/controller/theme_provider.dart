import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ThemeProviderClass extends ChangeNotifier {
  String textTheme = 's';
  ThemeMode tm = ThemeMode.light;

  ThemeMode get themeMode {
    if (currentThemeProv) {
      // print('############################################');
      // print('Current Theme with light $currentThemeProv');
      return ThemeMode.light;
    } else if (currentThemeProv == false) {
      // print('############################################');
      // print('Current Theme with dark $currentThemeProv');
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  Future<void> changeTheme(bool theme) async {
    currentThemeProv = theme;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('theme', theme);
    // print('############################################');
    // print('Current Theme $currentThemeProv');
  }

  // initialize() async {
  //   // print('Initialize Provider');
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   currentThemeProv = prefs.getBool('theme')!;
  //   changeTheme(currentThemeProv);
  //   notifyListeners();
  // }
}
