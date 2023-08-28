// ignore_for_file: unnecessary_new

import 'package:carros_car/VIEW/Home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerMenu extends StatelessWidget {
  //dados que vem do banco de dados
  final String usuario = 'Rogerio';
  final String email = 'rogeriocunhago@gmail.com';
  final String fotoPerfil = "img/perfil.jpg";

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
                child: Image.asset(fotoPerfil),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
          //home
          new ListTile(
            title: mostrarTitulo('Home'),
            subtitle: const Text('Pagina Inicial'),
            trailing: const FaIcon(FontAwesomeIcons.chevronCircleRight),
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
            title: mostrarTitulo('Gerenciar'),
            subtitle: const Text('Gerenciar Vendas'),
            trailing: const FaIcon(FontAwesomeIcons.chevronCircleRight),
            leading: const FaIcon(FontAwesomeIcons.listCheck),
            iconColor: Colors.red.shade900,

            //ir para a gerencia de vendas
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            },
          ),

          //configurações
          new ListTile(
            title: mostrarTitulo('Configurações'),
            subtitle: const Text('Fazer ajustes na conta'),
            trailing: const FaIcon(FontAwesomeIcons.chevronCircleRight),
            leading: const FaIcon(FontAwesomeIcons.cogs),
            iconColor: Colors.blue.shade900,

            //ir para a Configuraçoes
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            },
          ),

          //logout
          new ListTile(
            title: mostrarTitulo('Logout'),
            subtitle: const Text('Sair do aplicativo'),
            trailing: const FaIcon(FontAwesomeIcons.chevronCircleRight),
            leading: const FaIcon(FontAwesomeIcons.signOut),
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
