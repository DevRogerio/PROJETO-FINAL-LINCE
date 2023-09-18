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
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    TextFormField(
                      controller: state.controllerName,
                      decoration: const InputDecoration(
                        hintText: 'Alterar nome',
                      ),
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return 'não pode estar vazio';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: state.controllerCNPJ,
                      decoration: const InputDecoration(
                        hintText: 'Alterar CNPJ',
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

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Search()),
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
