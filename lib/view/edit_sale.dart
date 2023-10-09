import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'register_sale.dart';
import 'search_sale.dart';
import 'utils/app_bar.dart';
import 'utils/menu.dart';

class EditSaleSearch extends StatelessWidget {
  const EditSaleSearch({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<RegistroStateSale>(
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
                          controller: state.controllerdealershipCut,
                          decoration: const InputDecoration(
                            label: Text('% concessionaria '),
                            labelStyle: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: state.controllerbusinessCut,
                          decoration: const InputDecoration(
                            label: Text('% loja '),
                            labelStyle: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: state.controllersafetyCut,
                          decoration: const InputDecoration(
                            label: Text('% caixa de segurança '),
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
                          height: 125,
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
