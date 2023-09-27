import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../controllers/database.dart';
import '../model/sales.dart';
import 'utils/app_bar.dart';
import 'utils/menu.dart';

class RegistroStateSale extends ChangeNotifier {
  RegistroStateSale() {
    load();
  }

  // String registerStoreName = 'nome';

  // int? registerStorecnpj;

  final _listUser = <Sale>[];
  final _formKey = GlobalKey<FormState>();

  final controller = SaleController();
  final _controllercpf = TextEditingController();
  final _controllername = TextEditingController();
  final _controllersoldWhen = TextEditingController();
  final _controllerdealershipCut = TextEditingController();
  final _controllerbusinessCut = TextEditingController();
  final _controllersafetyCut = TextEditingController();
  final _controllervehicleId = TextEditingController();
  final _controlleruserId = TextEditingController();
  final _controllerpriceSold = TextEditingController();

  Sale? _registerAtual;
  TextEditingController get controllercpf => _controllercpf;
  TextEditingController get controllername => _controllername;
  TextEditingController get controllersoldWhen => _controllersoldWhen;
  TextEditingController get controllerdealershipCut => _controllerdealershipCut;
  TextEditingController get controllerbusinessCut => _controllerbusinessCut;
  TextEditingController get controllersafetyCut => _controllersafetyCut;
  TextEditingController get controllervehicleId => _controllervehicleId;
  TextEditingController get controlleruserId => _controlleruserId;
  TextEditingController get controllerpriceSold => _controllerpriceSold;

  Sale? get registerAtual => _registerAtual;

  List<Sale> get listUser => _listUser;

  GlobalKey<FormState> get formKey => _formKey;

  Future<void> insert() async {
    final sale = Sale(
        cpf: int.parse(controllercpf.text),
        name: controllername.text,
        soldWhen: DateFormat('dd/MM/yyyy').parse(controllersoldWhen.text),
        dealershipCut: double.parse(controllerdealershipCut.text),
        businessCut: double.parse(controllerbusinessCut.text),
        safetyCut: double.parse(controllersafetyCut.text),
        vehicleId: int.parse(controllervehicleId.text),
        userId: int.parse(controlleruserId.text),
        priceSold: double.parse(
          controllerpriceSold.text,
        ));

    await controller.insert(sale);
    await load();

    controllername.clear();
    controllercpf.clear();
    controllersoldWhen.clear();
    controllerdealershipCut.clear();
    controllerbusinessCut.clear();
    controllersafetyCut.clear();
    controllervehicleId.clear();
    controlleruserId.clear();
    controllerpriceSold.clear();

    notifyListeners();
  }

  Future<void> delete(Sale sale) async {
    await controller.delete(sale);
    await load();

    notifyListeners();
  }

  Future<void> load() async {
    final list = await controller.select();
    listUser.clear();
    listUser.addAll(list);

    notifyListeners();
  }

  void editSearch(Sale sale) {
    _controllername.text = sale.name!;
    _controllercpf.text = sale.cpf.toString();
    _controllersoldWhen.text = sale.soldWhen.toString();
    _controllerdealershipCut.text = sale.dealershipCut.toString();
    _controllerbusinessCut.text = sale.businessCut.toString();
    _controllersafetyCut.text = sale.safetyCut.toString();
    _controllervehicleId.text = sale.vehicleId.toString();
    _controlleruserId.text = sale.userId.toString();
    _controllerpriceSold.text = sale.priceSold.toString();

    _registerAtual = Sale(
        name: sale.name,
        cpf: int.parse(controllercpf.text),
        soldWhen: DateTime.parse(controllersoldWhen.text),
        dealershipCut: double.parse(controllerdealershipCut.text),
        businessCut: double.parse(controllerbusinessCut.text),
        safetyCut: double.parse(controllersafetyCut.text),
        vehicleId: int.parse(controllervehicleId.text),
        userId: int.parse(controlleruserId.text),
        priceSold: double.parse(controllerpriceSold.text),
        id: sale.id);
  }

  Future<void> update() async {
    final registroEditado = Sale(
      id: _registerAtual?.id,
      name: controllername.text,
      cpf: int.parse(controllercpf.text),
      soldWhen: DateTime.parse(controllersoldWhen.text),
      dealershipCut: double.parse(controllerdealershipCut.text),
      businessCut: double.parse(controllerbusinessCut.text),
      safetyCut: double.parse(controllersafetyCut.text),
      vehicleId: int.parse(controllervehicleId.text),
      userId: int.parse(controlleruserId.text),
      priceSold: double.parse(controllerpriceSold.text),
    );

    await controller.update(registroEditado);
    _registerAtual = null;
    _controllername.clear();
    _controllercpf.clear();
    _controllersoldWhen.clear();
    _controllerdealershipCut.clear();
    _controllerbusinessCut.clear();
    _controllersafetyCut.clear();
    _controllervehicleId.clear();
    _controlleruserId.clear();
    _controllerpriceSold.clear();

    await load();
  }
}

/*class Register extends StatelessWidget {
  Register({
    Key? key,
  }) : super(key: key);
  final dropValue = ValueNotifier('');
  final dropOpcoes = [
    'loja Iniciante 74% - rede 25%',
    'loja Intermediario 79% - rede 20%',
    'loja Avançado 84% - rede 15%',
    'loja Especial 94% - rede 5%'
  ];*/

// final _formKey = GlobalKey<FormState>();
class RegisterSale extends StatelessWidget {
  ///
  RegisterSale({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegistroStateSale(),
      child: Consumer<RegistroStateSale>(
        builder: (_, state, __) {
          return Center(
            child: Scaffold(
              appBar: BarraSuperior(),
              drawer: const DrawerMenu(),
              body: Container(
                decoration: const BoxDecoration(
                    gradient:
                        LinearGradient(begin: Alignment.topCenter, colors: [
                  Colors.black,
                  Colors.black,
                  Colors.black,
                  Colors.black,
                  Colors.black,
                  Colors.black,
                ])),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  colors: [
                                Colors.black,
                                Colors.black,
                                Colors.black,
                                Colors.black,
                                Colors.black,
                                Colors.black,
                              ])),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: state._controllername,
                                  decoration: InputDecoration(
                                    labelText: 'nome',
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
                                    labelText: 'Documento(cpf)',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                              ),
                              /* Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ValueListenableBuilder(
                                  valueListenable: dropValue,
                                  builder: ((context, value, _) {
                                    return DropdownButtonFormField<String>(
                                      icon: const Icon(Icons.drive_eta),
                                      hint: const Text(
                                          'Escolha o Nivel de Autonomia'),
                                      decoration: InputDecoration(
                                          label:
                                              const Text('Nivel de Autonomia'),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          )),
                                      value: (value.isEmpty) ? null : value,
                                      onChanged: (escolha) =>
                                          dropValue.value = escolha.toString(),
                                      items: dropOpcoes
                                          .map(
                                            (op) => DropdownMenuItem(
                                              value: op,
                                              child: Text(op),
                                            ),
                                          )
                                          .toList(),
                                    );
                                  }),
                                ),
                              ),*/
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: state._controllersoldWhen,
                                  inputFormatters: [
                                    MaskTextInputFormatter(mask: '##/##/####')
                                  ],
                                  decoration: InputDecoration(
                                    labelText: 'data da venda',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: state._controllerdealershipCut,
                                  decoration: InputDecoration(
                                    labelText: 'concessionária',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: state._controllerbusinessCut,
                                  decoration: InputDecoration(
                                    labelText: 'businessCut',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: state._controllersafetyCut,
                                  decoration: InputDecoration(
                                    labelText: 'corte de segurança',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: state._controllervehicleId,
                                  decoration: InputDecoration(
                                    labelText: 'vehicleId',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: state._controlleruserId,
                                  decoration: InputDecoration(
                                    labelText: 'userId',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: state._controllerpriceSold,
                                  decoration: InputDecoration(
                                    labelText: 'preço de venda',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
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
    final state = Provider.of<Sale>(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.red.shade900),
            onPressed: () async {
              await state.insert();
            },
            child: const Text('cadastro'),
          )
        ],
      ),
    );
  }
}
