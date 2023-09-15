//import 'package:carros_car/VIEW/register.dart';

import 'package:flutter/material.dart';

import '../VIEW/Home.dart';
//import '../VIEW/LoginPage.dart';
import '../VIEW/funcionalidades/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      debugShowCheckedModeBanner: false,
      theme: style(),
    );
  }
}
