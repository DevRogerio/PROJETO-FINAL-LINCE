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
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    TextFormField(
                      controller: state.controllermodel,
                      decoration: const InputDecoration(
                        hintText: 'Alterar modelo',
                      ),
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return 'não pode estar vazio';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: state.controllerbrand,
                      decoration: const InputDecoration(
                        hintText: 'Alterar marca',
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade900),
                      onPressed: () async {
                        //print(state.registeratual);

                        if (state.registeratual != null) {
                          state.editSearch;
                          await state.update();
                        } else {
                          await state.insert();
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchVehicles()),
                        );
                      },
                      child: const Text('atualizar'),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
