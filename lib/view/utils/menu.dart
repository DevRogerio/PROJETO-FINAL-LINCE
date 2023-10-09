// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../home.dart';
import '../register.dart';
import '../register_sale.dart';
import '../register_vehicles.dart';

class DrawerMenu extends StatelessWidget {
  //dados que vem do banco de dados
  //final String usuario = RegisterStoreTable.name;
  //final String email = RegisterStoreTable.cnpj;

  const DrawerMenu({super.key});
  //final String fotoPerfil = "img/perfil.jpg";

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
              accountName: Text(username),
              accountEmail: Text(state.controllerPassword.text),
              currentAccountPicture: CircleAvatar(
                child: ClipRRect(
                  // child: Image.asset(fotoPerfil),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            //home

            // if (state.usuario.id == 1)

            ListTile(
              title: mostrarTitulo('Home'),
              subtitle: const Text('Pagina Inicial'),
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
                    title: mostrarTitulo('Lojas'),
                    subtitle: const Text('Cadastrar Lojas Parceiras'),
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
              title: mostrarTitulo('Veiculos'),
              subtitle: const Text('Cadastrar Veiculos'),
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

            //logout
            new ListTile(
              title: mostrarTitulo('Vendas'),
              subtitle: const Text('Registro de vendas'),
              // ignore: deprecated_member_use
              trailing: const FaIcon(FontAwesomeIcons.chevronCircleRight),
              leading: const FaIcon(FontAwesomeIcons.dollarSign),
              iconColor: Colors.red.shade900,

              //ir para a pagina inicial
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterSale(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
