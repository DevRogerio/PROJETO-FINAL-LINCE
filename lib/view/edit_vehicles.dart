import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'register_vehicles.dart';
import 'search_vehicles.dart';
import 'utils/app_bar.dart';
import 'utils/menu.dart';

class EditVehicles extends StatelessWidget {
  const EditVehicles({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<RegistroStateVeiculos>(
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
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Card(
                color: Colors.black,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: state.controllerbrand,
                          decoration: const InputDecoration(
                            label: Text('Marca'),
                            labelStyle: TextStyle(color: Colors.red),
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
                          decoration: const InputDecoration(
                            label: Text('Modelo '),
                            labelStyle: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: state.controllerplate,
                          decoration: const InputDecoration(
                            label: Text('Placa '),
                            labelStyle: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: state.controllerbuiltYear,
                          decoration: const InputDecoration(
                            label: Text('Ano de fabricação '),
                            labelStyle: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: state.controllervehicleYear,
                          decoration: const InputDecoration(
                            label: Text('Ano do veículo'),
                            labelStyle: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: state.controllerpricePaid,
                          decoration: const InputDecoration(
                            label: Text('Preço '),
                            labelStyle: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: state.controllerpurchasedWhen,
                          decoration: const InputDecoration(
                            label: Text('Data da compra'),
                            labelStyle: TextStyle(color: Colors.red),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        FormField(builder: (field) {
                          return Container(
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
                            //print(state.registeratual);

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
                          child: const Text('atualizar'),
                        )
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
