//import 'package:carros_car/MODEL/register_store.dart';
//import 'package:carros_car/CONTROLLER/database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'edit_perfil_search.dart';
import 'register.dart';
import 'utils/app_bar.dart';
import 'utils/menu.dart';

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
            body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Colors.black,
                Colors.black,
                Colors.black,
                Colors.black,
                Colors.black,
                Colors.black,
              ])),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 75),
                itemCount: state.listUser.length,
                //state.controller.select().toString().length,
                //registerStoreTable.toString().length,
                //state.load().toString().length,
                itemBuilder: (context, index) {
                  // final RegisterStore = state.controllercnpj.value.text.length;
                  final registerStoreTable = state.listUser[index];
                  return Container(
                    color: Colors.red.shade900,
                    padding: const EdgeInsets.all(5),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                    child: ListTile(
                      leading: Text(registerStoreTable.id.toString()),
                      title: Text(registerStoreTable.name.toString()),
                      subtitle: Text(registerStoreTable.cnpj.toString()),
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
                                await state.delete(registerStoreTable);
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 25,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                // state.updateRegister();

                                state.editSearch(registerStoreTable);
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider.value(
                                      value: state,
                                      child: const EditPerfilSearch(),
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
            ),
          );
        },
      ),
    );
  }
}
