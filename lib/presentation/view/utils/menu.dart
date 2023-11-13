// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../generated/l10n.dart';
import '../../registerstore/register_store_screen.dart';
import '../../registrationvehicles/registration_vehicles_screen.dart';
import '../../state/registerstore/register_store_state.dart';
import '../home.dart';
//import '../register_pages/register_vehicles.dart';

/// Screen of DrawerMenu
class DrawerMenu extends StatelessWidget {
  /// Class of DrawerMenu
  const DrawerMenu({super.key});

  /// title
  Text mostrarTitulo(String texto) {
    return Text(
      texto,
      style: const TextStyle(fontSize: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RegistroState>(
      context,
    );
    final userid = state.logUser!.id;
    final username = state.logUser!.name;
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.black,
          Colors.black,
          Colors.black,
          Colors.black,
          Colors.black,
          Colors.black,
        ])),
        child: ListView(
          children: [
            //informações do usuario
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Colors.red,
                Colors.red,
                Colors.red,
                Colors.red,
                Colors.red,
                Colors.red,
              ])),
              accountName: Text(username!),
              accountEmail: Text(state.controllerPassword.text),
              currentAccountPicture: CircleAvatar(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            //home

            // if (state.usuario.id == 1)

            ListTile(
              title: mostrarTitulo('Home'),
              subtitle: Text(Inter.current.HomePage),
              // ignore: deprecated_member_use
              trailing: const FaIcon(FontAwesomeIcons.chevronCircleRight),
              // ignore: deprecated_member_use
              leading: const FaIcon(FontAwesomeIcons.home),
              iconColor: Colors.red.shade900,

              //ir para a Home
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ),
                );

                // ignore: unrelated_type_equality_checks
              },
            ),

            //Gerencia
            userid == 1
                ? ListTile(
                    title: mostrarTitulo(Inter.current.Stores),
                    subtitle: Text(Inter.current.RegisterPartnerStores),
                    // ignore: deprecated_member_use
                    trailing: const FaIcon(FontAwesomeIcons.chevronCircleRight),
                    leading: const FaIcon(FontAwesomeIcons.listCheck),
                    iconColor: Colors.red.shade900,

                    //ir para a gerencia de vendas
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Register(),
                        ),
                      );
                    },
                  )
                : Container(),

            //configurações
            new ListTile(
              title: mostrarTitulo(Inter.current.Cars),
              subtitle: Text(Inter.current.RegisterCars),
              // ignore: deprecated_member_use
              trailing: const FaIcon(FontAwesomeIcons.chevronCircleRight),
              leading: const FaIcon(FontAwesomeIcons.car),
              iconColor: Colors.red.shade900,

              //ir para a Configuraçoes
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterVehicles(),
                  ),
                );
              },
            ),
            IconButton(
              alignment: Alignment.bottomLeft,
              onPressed: state.toggleTheme,
              icon: Icon(
                state.ligthMode ? Icons.dark_mode : Icons.light_mode,
              ),
            ),
            IconButton(
              alignment: Alignment.bottomLeft,
              onPressed: state.toggleLanguage,
              icon: const Icon(Icons.language
                  //  state.language,
                  ),
              /* new ListTile(
              title: mostrarTitulo('idiomas'),
              subtitle: const Text('trocar idiomas'),
              // ignore: deprecated_member_use
              trailing: StatefulBuilder(builder: (context, setState) {
                return Switch(
                  value: valor,
                  onChanged: (newVal) => setState(() =>valor = newVal),
                );
              }),
            ),*/
            ),
          ],
        ),
      ),
    );
  }
}
