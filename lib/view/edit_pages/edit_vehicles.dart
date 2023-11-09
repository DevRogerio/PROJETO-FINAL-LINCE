import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../generated/l10n.dart';
import '../register_pages/register_vehicles.dart';
import '../search_pages/search_vehicles.dart';
import '../utils/app_bar.dart';
import '../utils/menu.dart';

/// Screen of EditVehicles
class EditVehicles extends StatelessWidget {
  /// class of EditVehicles
  const EditVehicles({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<RegistroStateVeiculos>(
      builder: (_, state, __) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: BarraSuperior(),
          drawer: const DrawerMenu(),
          body: Container(
            width: 5000,
            height: 5000,
            decoration: BoxDecoration(
              color: Colors.red.shade900,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                padding: const EdgeInsets.all(16),
                width: 5000,
                height: 5000,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: state.controllerbrand,
                          decoration: InputDecoration(
                            label: Text(Inter.current.brand),
                            labelStyle: const TextStyle(color: Colors.red),
                          ),
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return 'não pode estar vazio';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: state.controllerModel,
                          decoration: InputDecoration(
                            label: Text(Inter.current.Model),
                            labelStyle: const TextStyle(color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: state.controllerplate,
                          decoration: InputDecoration(
                            label: Text(Inter.current.plate),
                            labelStyle: const TextStyle(color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: state.controllerbuiltYear,
                          decoration: InputDecoration(
                            label: Text(Inter.current.builtYear),
                            labelStyle: const TextStyle(color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: state.controllervehicleYear,
                          decoration: InputDecoration(
                            label: Text(Inter.current.vehicleYear),
                            labelStyle: const TextStyle(color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: state.controllerpricePaid,
                          decoration: InputDecoration(
                            label: Text(Inter.current.pricePaid),
                            labelStyle: const TextStyle(color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: state.controllerpurchasedWhen,
                          decoration: InputDecoration(
                            label: Text(Inter.current.purchasedWhen),
                            labelStyle: const TextStyle(color: Colors.red),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        FormField(builder: (field) {
                          return SizedBox(
                            height: 600,
                            child: Image.file(
                              File(state.controllervehiclephoto!),
                            ),
                          );
                        }),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade900),
                          onPressed: () async {
                            if (state.registeratual != null) {
                              state.editSearchVehicles;
                              await state.update();
                            } else {
                              await state.insert();
                            }
                            if (context.mounted) {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SearchVehicles(),
                                ),
                              );
                            }
                          },
                          child: Text(Inter.current.update),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
