import 'package:carros_car/MODEL/RegisterStore.dart';
import 'package:carros_car/CONTROLLER/database.dart';
import 'package:carros_car/VIEW/funcionalidades/AppBar.dart';
import 'package:carros_car/VIEW/funcionalidades/menu.dart';
import 'package:carros_car/VIEW/register.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class search extends StatelessWidget {
  search({super.key});
  // final registerStoreTable = RegisterStore;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegistroState(),
      child: Consumer<RegistroState>(
        builder: (_, state, __) {
          return Scaffold(
            appBar: BarraSuperior(),
            drawer: DrawerMenu(),
            body: ListView.builder(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 75),
              itemCount: state.listUser.length,
              //state.controller.select().toString().length,
              //registerStoreTable.toString().length,
              //state.load().toString().length,
              itemBuilder: (context, index) {
                // final RegisterStore = state.controllercnpj.value.text.length;
                final RegisterStoreTable = state.listUser[index];
                return Container(
                  color: Colors.grey.shade900,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: ListTile(
                    leading: Text(RegisterStoreTable.id.toString()),
                    title: Text(RegisterStoreTable.name.toString()),
                    subtitle: Text(RegisterStoreTable.cnpj.toString()),
                    trailing: IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.userEdit,
                        color: Colors.red,
                        size: 32,
                      ),
                      onPressed: () {},
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
                
                  
                  
        




               

/*  IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.red,
                        size: 32,
                      ),
                      onPressed: () {
                        //
                      },
                    )*/