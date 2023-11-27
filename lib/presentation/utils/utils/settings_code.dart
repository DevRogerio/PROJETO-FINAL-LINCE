import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// key variable to save in preferences
const appThemeModeKey = 'appThemeMode';

/// Shared preferences key to the app language.
const appLanguageKey = 'appLanguageKey';

///class responsible for taking care of user configurations
class RegistroState extends ChangeNotifier {
  /// constructor as the init method to start preferences
  RegistroState() {
    unawaited(_init());
  }
  late final SharedPreferences _sharedPreferences;

  var _lightMode = true;

  /// Indicates if the light mode is active.
  bool get ligthMode => _lightMode;

  var _language = 'en';

  /// The selected language of the app.
  String get language => _language;

  /// Changes the [_language] value to the given [language].
  Future<void> toggleLanguagee({required String language}) async {
    _language = language;
    await _sharedPreferences.setString(appLanguageKey, _language);
    notifyListeners();
  }

  /// Toggles the theme between light and dark.
  Future<void> toggleTheme() async {
    _lightMode = !_lightMode;
    await _sharedPreferences.setBool(appThemeModeKey, _lightMode);
    notifyListeners();
  }

  Future<void> _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _lightMode = _sharedPreferences.getBool(appThemeModeKey) ?? true;
    _language = _sharedPreferences.getString(appLanguageKey) ?? 'en';

    notifyListeners();
  }
}
