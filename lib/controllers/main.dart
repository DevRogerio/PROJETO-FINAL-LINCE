import 'package:flutter/material.dart';

import '../view/login_page.dart';
import '../view/utils/style.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
      theme: style(),
    );
  }
}
