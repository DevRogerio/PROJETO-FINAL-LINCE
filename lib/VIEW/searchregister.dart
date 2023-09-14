//import 'package:carros_car/MODEL/RegisterStore.dart';
//import 'package:carros_car/CONTROLLER/database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'editperfilsearch.dart';
import 'funcionalidades/AppBar.dart';
import 'funcionalidades/menu.dart';
import 'register.dart';

class Search extends StatelessWidget {
  const Search({super.key});
  // final registerStoreTable = RegisterStore;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegistroState(),
      child: Consumer<RegistroState>(
        builder: (_, state, __) {
          return Scaffold(
            appBar: BarraSuperior(),
            drawer: const DrawerMenu(),
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
                  color: Colors.red.shade900,
                  padding: const EdgeInsets.all(5),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                  child: ListTile(
                    leading: Text(RegisterStoreTable.id.toString()),
                    title: Text(RegisterStoreTable.name.toString()),
                    subtitle: Text(RegisterStoreTable.cnpj.toString()),
                    trailing: IntrinsicWidth(
                      child: Row(
                        children: [
                          /* IconButton(
                            onPressed: () async {
                              //
                            },
                            icon: const Icon(
                              Icons.edit,
                              size: 20,
                            ),
                          ),*/
                          IconButton(
                            onPressed: () async {
                              state.delete(RegisterStoreTable);
                            },
                            icon: const Icon(
                              Icons.delete,
                              size: 25,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              // state.updateRegister();

                              state.editSearch(RegisterStoreTable);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChangeNotifierProvider.value(
                                    value: state,
                                    child: const editperfilsearch(),
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              // ignore: deprecated_member_use
                              FontAwesomeIcons.chevronCircleRight,
                              color: Colors.black,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
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
