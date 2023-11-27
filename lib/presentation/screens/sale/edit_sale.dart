import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/l10n.dart';
import '../../state/sale/sales_state.dart';
import '../../utils/utils/app_bar.dart';
import '../../utils/utils/menu.dart';

/// Screen of EditSaleSearch
class EditSaleSearch extends StatelessWidget {
  /// class of EditSaleSearch
  const EditSaleSearch({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<RegistroStateSale>(
      builder: (_, state, __) {
        return Scaffold(
          backgroundColor: state.ligthMode ? Colors.white : Colors.black,
          appBar: BarraSuperior(),
          drawer: const DrawerMenu(),
          body: Container(
            width: 5000,
            height: 5000,
            decoration: BoxDecoration(
              color: state.ligthMode ? Colors.white : Colors.black,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                padding: const EdgeInsets.all(16),
                width: 5000,
                height: 5000,
                decoration: BoxDecoration(
                  color: state.ligthMode ? Colors.white : Colors.black,
                  borderRadius: BorderRadius.circular(100),
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
