import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../register_pages/register_sale.dart';
import '../search_pages/search_sale.dart';
import '../utils/app_bar.dart';
import '../utils/menu.dart';

/// Screen of EditSaleSearch
class EditSaleSearch extends StatelessWidget {
  /// class of EditSaleSearch
  const EditSaleSearch({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<RegistroStateSale>(
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
                          controller: state.controllername,
                          decoration: const InputDecoration(
                            label: Text('nome '),
                            labelStyle: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: state.controllercpf,
                          decoration: const InputDecoration(
                            label: Text('cpf '),
                            labelStyle: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: state.controllersoldWhen,
                          decoration: const InputDecoration(
                            label: Text('data da venda '),
                            labelStyle: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: state.controllerpriceSold,
                          decoration: const InputDecoration(
                            label: Text(' preço de venda '),
                            labelStyle: TextStyle(color: Colors.red),
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade900),
                          onPressed: () async {
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
                                  builder: (context) => const SearchSale(),
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
