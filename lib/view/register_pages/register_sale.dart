import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

//import '../model/sales.dart';
import '../../MODEL/register_store.dart';
import '../../MODEL/sales.dart';
import '../../controllers/database.dart';
import '../../model/autonomy_level.dart';
import '../utils/app_bar.dart';
import '../utils/menu.dart';
import 'register.dart';

/// Sales Record Management
class RegistroStateSale extends ChangeNotifier {
  /// Constructs a stateSale registry instance
  RegistroStateSale(this.user) {
    unawaited(load(user!.id!));
  }

  /// user
  final RegisterStore? user;
  final _listSale = <Sale>[];
  final _formKey = GlobalKey<FormState>();

  /// controller of SaleController
  final controller = SaleController();
  final _controllercpf = TextEditingController();
  final _controllername = TextEditingController();
  final _controllersoldWhen = TextEditingController();

  final _controlleruserId = TextEditingController();
  final _controllerpriceSold = TextEditingController();

  Sale? _registerAtual;
  final _listAutomomydata = <AutonomyLevel>[];

  /// get from autonomy list
  List<AutonomyLevel> get listAutonomydata => _listAutomomydata;

  double? dealershipCut;
  double? businessCut;
  double? safetyCut;

  ///controller db from autonomy table
  final controllerAutonomy = AutonomyControler();

  /// Used to manage social security information [controllercpf]
  TextEditingController get controllercpf => _controllercpf;

  /// Manage name information
  TextEditingController get controllername => _controllername;

  /// Manage soldWhen information

  TextEditingController get controllersoldWhen => _controllersoldWhen;

  /// Manage userId information
  TextEditingController get controlleruserId => _controlleruserId;

  /// Manage priceSold information
  TextEditingController get controllerpriceSold => _controllerpriceSold;

  /// var editing
  Sale? get registerAtual => _registerAtual;

  /// list sale
  List<Sale> get listSale => _listSale;

  /// formkey
  GlobalKey<FormState> get formKey => _formKey;

  /// Method insert
  Future<void> insert() async {
    final sale = Sale(
      cpf: int.parse(controllercpf.text),
      name: controllername.text,
      soldWhen: DateFormat('dd/MM/yyyy').parse(controllersoldWhen.text),
      userId: user!.id!,
      priceSold: double.parse(_controllerpriceSold.text),
      dealershipCut:
          (dealershipCut! / 100) * double.parse(_controllerpriceSold.text),
      businessCut:
          (businessCut! / 100) * double.parse(_controllerpriceSold.text),
      safetyCut: (safetyCut! / 100) * double.parse(_controllerpriceSold.text),
    );

    await controller.insert(sale);
    await load(user!.id!);

    controllername.clear();
    controllercpf.clear();
    controllersoldWhen.clear();

    controlleruserId.clear();
    controllerpriceSold.clear();

    notifyListeners();
  }

  /// Method delete
  Future<void> delete(Sale sale) async {
    await controller.delete(sale);
    await load(user!.id!);

    notifyListeners();
  }

  /// Method load
  Future<void> load(int userId) async {
    final list = <Sale>[];
    if (user!.id != 1) {
      list.addAll(await controller.selectByUser(userId));
    } else {
      list.addAll(await controller.selectAll());
    }

    listSale.clear();
    listSale.addAll(list);

    notifyListeners();
  }

  /// Method edit
  void editSearch(Sale sale) {
    _controllername.text = sale.name.toString();
    _controllercpf.text = sale.cpf.toString();
    _controllersoldWhen.text = sale.soldWhen.toString();

    _controlleruserId.text = sale.userId.toString();
    _controllerpriceSold.text = sale.priceSold.toString();

    _registerAtual = Sale(
        name: sale.name,
        cpf: int.parse(controllercpf.text),
        soldWhen: DateTime.parse(controllersoldWhen.text),
        userId: int.parse(controlleruserId.text),
        priceSold: double.parse(controllerpriceSold.text),
        id: sale.id);
  }

  /// method update
  Future<void> update() async {
    final registroEditado = Sale(
      id: _registerAtual?.id,
      name: controllername.text,
      cpf: int.parse(controllercpf.text),
      soldWhen: DateTime.parse(controllersoldWhen.text),
      userId: int.parse(controlleruserId.text),
      priceSold: double.parse(controllerpriceSold.text),
    );

    await controller.update(registroEditado);
    _registerAtual = null;
    _controllername.clear();
    _controllercpf.clear();
    _controllersoldWhen.clear();

    _controlleruserId.clear();
    _controllerpriceSold.clear();

    await load(user!.id!);
  }

  Future<void> dataAutonomy(int user) async {
    final list = await controllerAutonomy.select(user);

    if (list.isNotEmpty) {
      dealershipCut = list[0].networkPercentage;
      businessCut = list[0].storePercentage;
      safetyCut = list[0].networkSecurity;
    }
    notifyListeners();
  }
}

/// Screen of RegisterSale
class RegisterSale extends StatelessWidget {
  /// class of RegisterSale
  RegisterSale({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final person = ModalRoute.of(context)!.settings.arguments as RegisterStore?;
    final mainState = Provider.of<RegistroState>(context);
    return ChangeNotifierProvider(
      create: (context) => RegistroStateSale(mainState.logUser),
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
                                  controller: state._controllerpriceSold,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    labelText: 'preço de venda',
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
            child: const Text('Registrar Venda'),
          )
        ],
      ),
    );
  }
}
