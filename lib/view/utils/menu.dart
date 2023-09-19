// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../home.dart';
import '../register.dart';
import '../register_vehicles.dart';

class DrawerMenu extends StatelessWidget {
  //dados que vem do banco de dados
  final String usuario = 'Rogerio';
  final String email = 'rogeriocunhago@gmail.com';

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
    return Drawer(
      child: ListView(
        children: [
          //informações do usuario
          UserAccountsDrawerHeader(
            accountName: Text(usuario),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              child: ClipRRect(
                // child: Image.asset(fotoPerfil),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
          //home
          new ListTile(
            title: mostrarTitulo('Home'),
            subtitle: const Text('Pagina Inicial'),
            // ignore: deprecated_member_use
            trailing: const FaIcon(FontAwesomeIcons.chevronCircleRight),
            // ignore: deprecated_member_use
            leading: const FaIcon(FontAwesomeIcons.home),
            iconColor: Colors.purple.shade600,

            //ir para a Home
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            },
          ),

          //Gerencia
          new ListTile(
            title: mostrarTitulo('Lojas'),
            subtitle: const Text('Cadastrar Lojas Parceiras'),
            // ignore: deprecated_member_use
            trailing: const FaIcon(FontAwesomeIcons.chevronCircleRight),
            leading: const FaIcon(FontAwesomeIcons.listCheck),
            iconColor: Colors.red.shade900,

            //ir para a gerencia de vendas
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Register(),
                ),
              );
            },
          ),

          //configurações
          new ListTile(
            title: mostrarTitulo('Veiculos'),
            subtitle: const Text('Cadastrar Veiculos'),
            // ignore: deprecated_member_use
            trailing: const FaIcon(FontAwesomeIcons.chevronCircleRight),
            leading: const FaIcon(FontAwesomeIcons.car),
            iconColor: Colors.blue.shade900,

            //ir para a Configuraçoes
            onTap: () {
              Navigator.push(
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
            iconColor: Colors.green.shade900,

            //ir para a pagina inicial
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}