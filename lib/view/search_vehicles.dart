import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'edit_vehicles.dart';
import 'register_vehicles.dart';
import 'utils/app_bar.dart';
import 'utils/menu.dart';

/// Screen of Vehicles
class SearchVehicles extends StatelessWidget {
  /// Class of Vehicles
  const SearchVehicles({super.key});

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
              itemBuilder: (context, index) {
                final registrationTable = state.listvehicles[index];
                return Container(
                  color: Colors.red.shade900,
                  padding: const EdgeInsets.all(5),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                  child: ListTile(
                    leading: Image.file(
                      File(registrationTable.vehiclephoto!),
                    ), //Text(registrationTable.id.toString()),
                    title: Text(registrationTable.model.toString()),
                    subtitle: /* Image.file(
                      File(registrationTable.vehiclephoto!),
                    ),*/
                        Text(registrationTable.id.toString()),
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
                              state.delete(registrationTable);
                            },
                            icon: const Icon(
                              Icons.delete,
                              size: 25,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              // state.updateRegister();

                              state.editSearchVehicles(registrationTable);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChangeNotifierProvider.value(
                                    value: state,
                                    child: const EditVehicles(),
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
