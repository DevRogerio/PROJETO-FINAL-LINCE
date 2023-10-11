import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'edit_vehicles.dart';

import 'register.dart';
import 'register_vehicles.dart';
import 'utils/app_bar.dart';
import 'utils/menu.dart';

/// Screen of Vehicles
class SearchVehicles extends StatelessWidget {
  /// Class of Vehicles
  const SearchVehicles({super.key});

  @override
  Widget build(BuildContext context) {
    final mainState = Provider.of<RegistroState>(context);
    return ChangeNotifierProvider(
      create: (context) => RegistroStateVeiculos(mainState.logUser),
      child: Consumer<RegistroStateVeiculos>(
        builder: (_, state, __) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: BarraSuperior(),
            drawer: const DrawerMenu(),
            body: Container(
              width: 5000,
              height: 5000,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 75),
                itemCount: state.listvehicles.length,
                itemBuilder: (context, index) {
                  final registrationTable = state.listvehicles[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 30),
                    width: 85,
                    height: 85,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ListTile(
                      leading: Image.file(
                        File(registrationTable.vehiclephoto!),
                      ),
                      title: Text(registrationTable.model.toString()),
                      subtitle: Text(registrationTable.brand.toString()),
                      trailing: IntrinsicWidth(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                await state.delete(registrationTable);
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 25,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                state.editSearchVehicles(registrationTable);
                                await Navigator.push(
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
                                color: Colors.white,
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
