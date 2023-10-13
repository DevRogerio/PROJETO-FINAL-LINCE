import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../edit_pages/edit_sale.dart';
import '../register_pages/register.dart';
import '../register_pages/register_sale.dart';
import '../utils/app_bar.dart';
import '../utils/menu.dart';

/// Screen of Sale
class SearchSale extends StatelessWidget {
  /// class of Sale
  const SearchSale({super.key});

  @override
  Widget build(BuildContext context) {
    final mainState = Provider.of<RegistroState>(context);
    return ChangeNotifierProvider(
      create: (context) => RegistroStateSale(mainState.logUser),
      child: Consumer<RegistroStateSale>(
        builder: (_, state, __) {
          final numberFormatter = NumberFormat('###,###,###.00');
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: BarraSuperior(),
            drawer: const DrawerMenu(),
            body: Container(
              width: 5000,
              height: 5000,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 75),
                itemCount: state.listSale.length,
                itemBuilder: (context, index) {
                  final salesTable = state.listSale[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 25),
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ListTile(
                      leading: Text(salesTable.name.toString()),
                      title: Text(
                          'R\$${numberFormatter.format(salesTable.priceSold)}'),
                      subtitle: Text(salesTable.cpf.toString()),
                      trailing: IntrinsicWidth(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                await state.delete(salesTable);
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 25,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                state.editSearch(salesTable);
                                await Navigator.push(
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
                                color: Colors.white,
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
