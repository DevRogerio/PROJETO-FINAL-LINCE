import 'package:carros_car/MODEL/RegisterStore.dart';
import 'package:carros_car/VIEW/funcionalidades/AppBar.dart';
import 'package:carros_car/VIEW/funcionalidades/menu.dart';
import 'package:carros_car/VIEW/register.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class editperfilsearch extends StatelessWidget {
  const editperfilsearch({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegistroState(),
      child: Consumer<RegistroState>(
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
                          //await state.updateRegister();
                          //await state.load();
                          //  await state.insert();
                          if (state.registeratual != null) {
                            await state.updateRegister();
                          } else {
                            await state.insert();
                          }
                        },
                        child: Text('atualizar'),
                      )
                    ],
                  ),
                ),
              ),
            ),

            /* floatingActionButton: FloatingActionButton(
        child: const Text('atualizar'),
        onPressed: () {},
      ),*/
          );
        },
      ),
    );
  }
}
