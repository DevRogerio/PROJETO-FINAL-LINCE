import 'package:flutter/material.dart';
import '../VIEW/login_page.dart';
import '../view/home.dart';
import '../view/utils/style.dart';

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
