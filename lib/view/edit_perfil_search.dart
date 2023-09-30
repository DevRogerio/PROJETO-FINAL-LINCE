import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'register.dart';
import 'search_register.dart';
import 'utils/app_bar.dart';
import 'utils/menu.dart';

class EditPerfilSearch extends StatelessWidget {
  const EditPerfilSearch({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<RegistroState>(
      builder: (_, state, __) {
        return Scaffold(
          appBar: BarraSuperior(),
          drawer: const DrawerMenu(),
          body: Container(
            height: 1000,
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
                          controller: state.controllerName,
                          decoration: const InputDecoration(
                            label: Text('alterar nome'),
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
                          controller: state.controllerPassword,
                          decoration: const InputDecoration(
                            label: Text('alterar senha'),
                            labelStyle: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: state.controllerCNPJ,
                          decoration: const InputDecoration(
                            label: Text('alterar cnpj'),
                            labelStyle: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: state.controllerAutonomyLevelID,
                          decoration: const InputDecoration(
                            label: Text('alterar autonomia'),
                            labelStyle: TextStyle(color: Colors.red),
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

                            if (state.registerAtual != null) {
                              state.editSearch;
                              await state.update();
                            } else {
                              await state.insert();
                            }

                            if (context.mounted) {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Search(),
                                ),
                              );
                            }
                          },
                          child: const Text('atualizar'),
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
