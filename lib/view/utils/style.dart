import 'package:flutter/material.dart';

ThemeData style() {
  var base = ThemeData.dark();
  return base.copyWith(
      primaryColor: Colors.black,
      colorScheme: const ColorScheme.dark(),

      //Botao
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: Colors.red));
}
