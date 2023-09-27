import 'package:carros_car/view/utils/menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'register_sale.dart';
import 'search_sale.dart';
import 'utils/app_bar.dart';

class EditSaleSearch extends StatelessWidget {
  const EditSaleSearch({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<RegistroStateSale>(
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
                      controller: state.controllername,
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
                      controller: state.controllercpf,
                      decoration: const InputDecoration(
                        hintText: 'Alterar cpf',
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
                          Navigator.push(
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
        );
      },
    );
  }
}
