import 'package:carros_car/MODEL/RegisterStore.dart';
import 'package:carros_car/VIEW/funcionalidades/AppBar.dart';
import 'package:carros_car/VIEW/funcionalidades/menu.dart';
import 'package:carros_car/VIEW/register.dart';
import 'package:carros_car/VIEW/searchregister.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../CONTROLLER/database.dart';

// ignore: camel_case_types
class editperfilsearch extends StatelessWidget {
  const editperfilsearch({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<RegistroState>(
      builder: (_, state, __) {
        return Scaffold(
          appBar: BarraSuperior(),
          drawer: DrawerMenu(),
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
                      controller: state.controllercnpj,
                      decoration: const InputDecoration(
                        hintText: 'Alterar CNPJ',
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red.shade900),
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
                          MaterialPageRoute(builder: (context) => search()),
                        );
                      },
                      child: Text('atualizar'),
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
