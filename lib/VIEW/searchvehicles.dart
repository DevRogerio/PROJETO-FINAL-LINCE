import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

//import '../MODEL/RegistrationVehicles.dart';
import 'editvehicles.dart';
import 'funcionalidades/AppBar.dart';
import 'funcionalidades/menu.dart';
import 'registervehicles.dart';

class Searchvehicles extends StatelessWidget {
  const Searchvehicles({super.key});
  // final registerStoreTable = RegisterStore;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegistroStateVeiculos(),
      child: Consumer<RegistroStateVeiculos>(
        builder: (_, state, __) {
          return Scaffold(
            appBar: BarraSuperior(),
            drawer: const DrawerMenu(),
            body: ListView.builder(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 75),
              itemCount: state.listvehicles.length,
              //state.controller.select().toString().length,
              //registerStoreTable.toString().length,
              //state.load().toString().length,
              itemBuilder: (context, index) {
                // final RegisterStore = state.controllercnpj.value.text.length;
                final RegistrationTable = state.listvehicles[index];
                return Container(
                  color: Colors.red.shade900,
                  padding: const EdgeInsets.all(5),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                  child: ListTile(
                    leading: Text(RegistrationTable.id.toString()),
                    title: Text(RegistrationTable.model.toString()),
                    subtitle: Text(RegistrationTable.plate.toString()),
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
                              state.delete(RegistrationTable);
                            },
                            icon: const Icon(
                              Icons.delete,
                              size: 25,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              // state.updateRegister();

                              state.editSearch(RegistrationTable);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChangeNotifierProvider.value(
                                    value: state,
                                    child: const editvehicles(),
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
