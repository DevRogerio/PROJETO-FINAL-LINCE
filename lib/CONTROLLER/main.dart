//import 'package:carros_car/VIEW/Home.dart';
import 'package:carros_car/VIEW/LoginPage.dart';

import 'package:carros_car/VIEW/funcionalidades/style.dart';
//import 'package:carros_car/VIEW/register.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      theme: style(),
    );
  }
}
