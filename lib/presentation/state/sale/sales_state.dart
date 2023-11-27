import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../entities/autonomy_level.dart';
import '../../../entities/register_store.dart';
import '../../../entities/registration_vehicles.dart';
import '../../../entities/sales.dart';
import '../../../repositories/repository/autonomy_table_repository.dart';
import '../../../repositories/repository/sales_table_repository.dart';

/// Sales Record Management
class RegistroStateSale extends ChangeNotifier {
  /// Constructs a stateSale registry instance
  RegistroStateSale(
    this.user,
    this.vehicle,
  ) {
    unawaited(load(user!.id!));
  }
  final _lightMode = false;

  /// Defines a getter method that allows you to access
  /// the value of the _lightMode.
  bool get ligthMode => _lightMode;

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
  final _dealershipCut = TextEditingController();
  final _businessCut = TextEditingController();

  Sale? _registerAtual;
  final _listAutomomydata = <AutonomyLevel>[];

  /// object vehicle
  final RegistrationVehicles? vehicle;

  /// get from autonomy list
  List<AutonomyLevel> get listAutonomydata => _listAutomomydata;

  /// get porcentage user current
  double? dealershipPercentage;

  /// get porcentage from store
  double? businessPercentage;

  /// get porcentage securyt box
  double? safetyPercentage;

  ///controller db from autonomy table
  final controllerAutonomy = AutonomyControler();

  /// get dealershipCut
  TextEditingController get dealershipCut => _dealershipCut;

  /// get businessCut
  TextEditingController get businessCut => _businessCut;

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
      dealershipCut: (dealershipPercentage! / 100) *
          double.parse(_controllerpriceSold.text),
      businessCut:
          (businessPercentage! / 100) * double.parse(_controllerpriceSold.text),
      safetyCut:
          (safetyPercentage! / 100) * double.parse(_controllerpriceSold.text),
      vehicleid: vehicle!.id,
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
    _dealershipCut.text = sale.dealershipCut.toString();
    _businessCut.text = sale.businessCut.toString();

    _registerAtual = Sale(
        name: sale.name,
        cpf: int.parse(controllercpf.text),
        soldWhen: DateTime.parse(controllersoldWhen.text),
        userId: int.parse(controlleruserId.text),
        priceSold: double.parse(controllerpriceSold.text),
        dealershipCut: double.parse(dealershipCut.text),
        businessCut: double.parse(businessCut.text),
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
      dealershipCut: double.parse(dealershipCut.text),
      businessCut: double.parse(businessCut.text),
    );

    await controller.update(registroEditado);
    _registerAtual = null;
    _controllername.clear();
    _controllercpf.clear();
    _controllersoldWhen.clear();

    _controlleruserId.clear();
    _controllerpriceSold.clear();
    _dealershipCut.clear();
    _businessCut.clear();

    await load(user!.id!);
  }

  /// responsible for getting the autonomy level of the logged in
  ///  user chama no botao de vender
  Future<void> dataAutonomy(int user) async {
    final list = await controllerAutonomy.select(user);

    if (list.isNotEmpty) {
      dealershipPercentage = list[0].networkPercentage;
      businessPercentage = list[0].storePercentage;
      safetyPercentage = list[0].networkSecurity;
    }
    notifyListeners();
  }
}
