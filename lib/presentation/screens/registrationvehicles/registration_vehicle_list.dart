import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../state/registerstore/register_store_state.dart';
import '../../state/registrationvehicle/registration_vehicle_state.dart';
import '../../utils/utils/app_bar.dart';
import '../../utils/utils/menu.dart';
import 'edit_vehicles.dart';

/// Screen of Vehicles
class SearchVehicles extends StatelessWidget {
  /// Class of Vehicles
  const SearchVehicles({super.key});

  @override
  Widget build(BuildContext context) {
    final stateTheme = Provider.of<RegistroState>(context);
    final size = MediaQuery.of(context).size;
    final mainState = Provider.of<RegistroState>(context);
    return ChangeNotifierProvider(
      create: (context) => RegistroStateVeiculos(mainState.logUser),
      child: Consumer<RegistroStateVeiculos>(
        builder: (_, state, __) {
          return Scaffold(
            backgroundColor: stateTheme.ligthMode ? Colors.white : Colors.black,
            appBar: BarraSuperior(),
            drawer: const DrawerMenu(),
            body: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                color: stateTheme.ligthMode ? Colors.white : Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 75),
                itemCount: state.listvehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = state.listvehicles[index];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 1, vertical: 25),
                    width: size.width,
                    height: size.height * 0.15,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 214, 165, 115),
                        Color(0xFFDA2323),
                      ],
                    )),
                    child: Card(
                      elevation: 50,
                      child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 214, 165, 115),
                            Color(0xFFDA2323),
                          ],
                        )),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.file(
                              File(vehicle.vehiclephoto!),
                            ),
                          ),
                          title: Text(vehicle.model.toString()),
                          subtitle: Text(vehicle.brand.toString()),
                          trailing: IntrinsicWidth(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await state.delete(vehicle);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 25,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    state.editSearchVehicles(vehicle);
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
                                    // color: Colors.white,
                                    size: 35,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await Navigator.of(context).pushNamed(
                                      'RegisterSale',
                                      arguments: vehicle,
                                    );
                                  },
                                  icon: const Icon(
                                    FontAwesomeIcons.dollarSign,
                                    // color: Colors.white,
                                    size: 35,
                                  ),
                                )
                              ],
                            ),
                          ),
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
