import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/l10n.dart';
import '../../state/registerstore/register_store_state.dart';
import '../../state/sale/sales_state.dart';
import '../../utils/utils/app_bar.dart';
import '../../utils/utils/menu.dart';

/// Screen of EditSaleSearch
class EditSaleSearch extends StatelessWidget {
  /// class of EditSaleSearch
  const EditSaleSearch({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final stateTheme = Provider.of<RegistroState>(context);
    return Consumer<RegistroStateSale>(
      builder: (_, state, __) {
        return Scaffold(
          backgroundColor: stateTheme.ligthMode ? Colors.white : Colors.black,
          appBar: BarraSuperior(),
          drawer: const DrawerMenu(),
          body: Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 211, 202, 192),
                Color.fromARGB(255, 163, 16, 16),
              ],
            )),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                padding: const EdgeInsets.all(16),
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  color: stateTheme.ligthMode ? Colors.white : Colors.black,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: state.controllername,
                          enabled: false,
                          decoration: InputDecoration(
                            label: Text(Inter.current.name),
                            labelStyle: const TextStyle(color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: state.controllercpf,
                          enabled: false,
                          decoration: const InputDecoration(
                            label: Text('cpf '),
                            labelStyle: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: state.controllersoldWhen,
                          enabled: false,
                          decoration: InputDecoration(
                            label: Text(Inter.current.soldWhen),
                            labelStyle: const TextStyle(color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: state.controllerpriceSold,
                          enabled: false,
                          decoration: InputDecoration(
                            label: Text(Inter.current.priceSold),
                            labelStyle: const TextStyle(color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: state.dealershipCut,
                          enabled: false,
                          decoration: InputDecoration(
                            label: Text(Inter.current.dealershipCut),
                            labelStyle: const TextStyle(color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: state.businessCut,
                          enabled: false,
                          decoration: InputDecoration(
                            label: Text(Inter.current.businessCut),
                            labelStyle: const TextStyle(color: Colors.red),
                          ),
                        ),
                        const SizedBox(
                          height: 100,
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
