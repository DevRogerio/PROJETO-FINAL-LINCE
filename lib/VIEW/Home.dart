import 'package:carros_car/VIEW/funcionalidades/AppBar.dart';
import 'package:carros_car/VIEW/funcionalidades/menu.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //titulo do app
        appBar: new BarraSuperior(),

        // Menu
        drawer: new DrawerMenu(),

        //Corpo do app
        body: SingleChildScrollView(
          child: Column(
            children: [
              new Container(
                width: 150,
                padding: EdgeInsets.all(25),
                child: Text('TESTE'),
                color: Colors.blue,
                height: 150,
              )
            ],
          ),
        ));
  }
}
