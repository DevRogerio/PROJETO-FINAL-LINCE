import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import '../../../entities/registration_vehicles.dart';
import '../../../generated/l10n.dart';
import '../../state/registerstore/register_store_state.dart';
import '../../state/sale/sales_state.dart';
import '../../utils/utils/app_bar.dart';
import '../../utils/utils/menu.dart';

/// Screen of RegisterSale
class RegisterSale extends StatelessWidget {
  /// class of RegisterSale
  RegisterSale({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vehicle =
        ModalRoute.of(context)!.settings.arguments as RegistrationVehicles?;
    final mainState = Provider.of<RegistroState>(context);
    return ChangeNotifierProvider(
      create: (context) => RegistroStateSale(mainState.logUser, vehicle!),
      child: Consumer<RegistroStateSale>(
        builder: (_, state, __) {
          return Center(
            child: Scaffold(
              appBar: BarraSuperior(),
              drawer: const DrawerMenu(),
              body: Container(
                decoration: BoxDecoration(
                  color: state.ligthMode ? Colors.white : Colors.black,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                state.ligthMode ? Colors.white : Colors.black,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: state.controllername,
                                  decoration: InputDecoration(
                                    labelText: Inter.current.name,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: state.controllercpf,
                                  decoration: InputDecoration(
                                    labelText: Inter.current.documentCNPJ,
                                    hintText: '02652603000101',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: state.controllersoldWhen,
                                  inputFormatters: [
                                    MaskTextInputFormatter(mask: '##/##/####')
                                  ],
                                  decoration: InputDecoration(
                                    labelText: Inter.current.soldWhen,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: state.controllerpriceSold,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    labelText: Inter.current.priceSold,
                                    hintText: '\$ 00.000',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                  ),
                                ),
                              ),
                              const _ActionButton(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RegistroStateSale>(context);
    final state2 = Provider.of<RegistroState>(context);
    final iduser = state2.logUser!.id;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.red.shade900),
            onPressed: () async {
              await state.dataAutonomy(iduser!);
              await state.insert();
            },
            child: Text(Inter.current.register),
          )
        ],
      ),
    );
  }
}
