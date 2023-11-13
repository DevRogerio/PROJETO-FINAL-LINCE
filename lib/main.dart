import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'generated/l10n.dart';
import 'presentation/autonomy/autonomy_screen.dart';
import 'presentation/sale/sales_list_screen.dart';
import 'presentation/sale/sales_screen.dart';
import 'presentation/state/registerstore/register_store_state.dart';
import 'presentation/view/edit_pages/edit_sale.dart';
import 'presentation/view/edit_pages/edit_vehicles.dart';
import 'presentation/view/login_page.dart';
import 'presentation/view/utils/menu.dart';

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
              'DrawerMenu': (context) => const DrawerMenu(),
              'RegisterSale': (context) => RegisterSale(),
              'EditSaleSearch': (context) => const EditSaleSearch(),
            },
            home: LoginPage(state),
            debugShowCheckedModeBanner: false,
            theme: state.ligthMode ? ThemeData.light() : ThemeData.dark(),
            locale: Locale(state.language!),
            localizationsDelegates: const [
              Inter.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: Inter.delegate.supportedLocales,
          );
        },
      ),
    );
  }
}
