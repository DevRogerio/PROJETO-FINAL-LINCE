import 'package:carros_car/CONTROLLER/register_store_repository.dart';
import 'package:carros_car/MODEL/RegisterStore.dart';
import 'package:carros_car/VIEW/funcionalidades/AppBar.dart';
import 'package:carros_car/VIEW/funcionalidades/menu.dart';
import 'package:carros_car/VIEW/register.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class search extends StatelessWidget {
  search({super.key});

  final RegisterStoreTable registerStoreTable =
      Register() as RegisterStoreTable;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarraSuperior(),
      drawer: DrawerMenu(),
      body: ListView.builder(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 75),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.grey.shade900,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 45, vertical: 30),
              child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        // child: Image.asset(
                        // "perfil.jpg",
                        // width: 75,
                        //height: 75,
                        // fit: BoxFit.cover,
                        //)
                      ),
                      //nome loja
                      Column(
                        children: [
                          Text(
                            registerStoreTable
                                .insert(RegisterStore(name: "", password: "")),
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 24),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      )
                    ],
                  ),
                  trailing: IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.chevronRight,
                      color: Colors.red,
                      size: 32,
                    ),
                    onPressed: () {
                      //
                    },
                  )),
            );
          }),
    );
  }
}
