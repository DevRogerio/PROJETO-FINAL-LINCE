import 'package:carros_car/MODEL/RegisterStore.dart';
import 'package:carros_car/CONTROLLER/database.dart';
import 'package:carros_car/VIEW/funcionalidades/AppBar.dart';
import 'package:carros_car/VIEW/funcionalidades/menu.dart';
import 'package:carros_car/VIEW/register.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class search extends StatelessWidget {
  search({super.key});
  // final registerStoreTable = RegisterStore;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegistroState(),
      child: Consumer<RegistroState>(
        builder: (_, state, __) {
          return Scaffold(
            appBar: BarraSuperior(),
            drawer: DrawerMenu(),
            body: ListView.builder(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 75),
              itemCount: state.load().toString().length,
              //state.controller.select().toString().length,
              //registerStoreTable.toString().length,
              //state.load().toString().length,
              itemBuilder: (context, index) {
                // final RegisterStore = state.controllercnpj.value.text.length;
                final RegisterStoreTable = state.listUser.elementAt(index - 1);
                return ListTile(
                  leading: Text(RegisterStoreTable.id.toString()),
                  title: Text(RegisterStoreTable.name.toString()),
                  subtitle: Text(RegisterStoreTable.cnpj.toString()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

/*class _search extends StatelessWidget {
  const _search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RegistroState>(context);

    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, int index) {
        final RegisterStore = state.insert(index);

        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Card(
            child: InkWell(
              onTap: () {},
              child: ListTile(
                trailing: IconButton(
                    icon: const Icon(Icons.accessibility), onPressed: () {}),
              ),
            ),
          ),
        );
      },
    );
  }
}*/

/* return Container(
                  color: Colors.grey.shade900,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal: 45, vertical: 30),
                  child: ListTile(
                    // leading: Text(RegisterStore.length.toString()),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //nome loja
                        Column(
                          children: [
                            //Text(RegisterStore..length.toString()),
                            //Text(RegisterStoreTable.name.length.toString()),

                            //  Text()
                            // style: TextStyle(
                            // color: Colors.grey.shade700, fontSize: 24),
                            //  )
                          ],
                        ),
                        SizedBox(
                          width: 15,
                        )
                      ],
                    ),
                    trailing: IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.red,
                        size: 32,
                      ),
                      onPressed: () {
                        //
                      },
                    ),
                  ),
                );*/