import 'package:carros_car/view/utils/menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'edit_sale.dart';
import 'register_sale.dart';
import 'utils/app_bar.dart';

class SearchSale extends StatelessWidget {
  const SearchSale({super.key});
  // final registerStoreTable = RegisterStore;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegistroStateSale(),
      child: Consumer<RegistroStateSale>(
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
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 75),
                itemCount: state.listUser.length,
                //state.controller.select().toString().length,
                //registerStoreTable.toString().length,
                //state.load().toString().length,
                itemBuilder: (context, index) {
                  // final RegisterStore = state.controllercnpj.value.text.length;
                  final SalesTable = state.listUser[index];
                  return Container(
                    color: Colors.red.shade900,
                    padding: const EdgeInsets.all(5),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                    child: ListTile(
                      leading: Text(SalesTable.id.toString()),
                      title: Text(SalesTable.name.toString()),
                      subtitle: Text(SalesTable.cpf.toString()),
                      trailing: IntrinsicWidth(
                        child: Row(
                          children: [
                            /* IconButton(
                              onPressed: () async {
                                //
                              },
                              icon: const Icon(
                                Icons.edit,
                                size: 20,
                              ),
                            ),*/
                            IconButton(
                              onPressed: () async {
                                state.delete(SalesTable);
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 25,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                // state.updateRegister();

                                state.editSearch(SalesTable);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider.value(
                                      value: state,
                                      child: const EditSaleSearch(),
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                // ignore: deprecated_member_use
                                FontAwesomeIcons.chevronCircleRight,
                                color: Colors.black,
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
