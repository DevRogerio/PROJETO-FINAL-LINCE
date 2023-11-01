import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view/edit_pages/edit_vehicles.dart';
import '../view/login_page.dart';
import '../view/register_pages/autonomy_screen.dart';
import '../view/register_pages/register.dart';
import '../view/search_pages/search_sale.dart';

import '../view/utils/style.dart';

void main() async {
  runApp(const MyApp());
}

///initializing the [MyApp]
class MyApp extends StatelessWidget {
  /// The constructor of [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegistroState(),
      child: Consumer<RegistroState>(
        builder: (context, state, child) {
          return MaterialApp(
            routes: {
              'Autonomyedite': (context) => const Autonomyedite(),
              'SearchSale': (context) => const SearchSale(),
              'EditVehicles': (context) => const EditVehicles(),
            },
            home: LoginPage(state),
            debugShowCheckedModeBanner: false,
            theme: style(),
          );
        },
      ),
    );
  }
}
