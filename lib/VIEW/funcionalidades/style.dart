import 'package:flutter/material.dart';

ThemeData style() {
  ThemeData base = ThemeData.dark();
  return base.copyWith(
      primaryColor: Colors.black,
      colorScheme: ColorScheme.dark(),

      //Botao
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.red));
}
