import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view/login_page.dart';
import '../view/register.dart';
import '../view/utils/style.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegistroState(),
      child: Consumer<RegistroState>(
        builder: (context, state, child) {
          return MaterialApp(
            home: LoginPage(state),
            debugShowCheckedModeBanner: false,
            theme: style(),
          );
        },
      ),
    );
  }
}
