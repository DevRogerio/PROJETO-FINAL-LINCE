import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:flutter/material.dart';
import '../CONTROLLER/database.dart';
import '../MODEL/RegistrationVehicles.dart';
import 'funcionalidades/AppBar.dart';
import 'funcionalidades/menu.dart';

class RegistroStateVeiculos extends ChangeNotifier {
  RegistroStateVeiculos() {
    load();
  }
  //String? registrationVehiclespricePaid;
  //String? registrationVehiclespurchasedWhen;
  final controller = RegistrationVehiclesController();
  final _controllermodel = TextEditingController();
  final _controllerplate = TextEditingController();
  final _controllerbrand = TextEditingController();
  final _controllerbuiltYear = TextEditingController();
  final _controllervehicleYear = TextEditingController();
  final _controllervehiclephoto = TextEditingController();
  final _controllerpricePaid = TextEditingController();
  final _controllerpurchasedWhen = TextEditingController();
  final _controllerdealershipId = TextEditingController();
  RegisterVehicles? _registeratual;
  final _listvehicles = <RegistrationVehicles>[];

  TextEditingController get controllermodel => _controllermodel;
  TextEditingController get controllerplate => _controllerplate;
  TextEditingController get controllerbrand => _controllerbrand;
  TextEditingController get controllerbuiltYear => _controllerbuiltYear;
  TextEditingController get controllervehicleYear => _controllervehicleYear;
  TextEditingController get controllervehiclephoto => _controllervehiclephoto;
  TextEditingController get controllerpricePaid => _controllerpricePaid;
  TextEditingController get controllerpurchasedWhen => _controllerpurchasedWhen;
  TextEditingController get controllerdealershipId => _controllerdealershipId;
  RegisterVehicles? get registeratual => _registeratual;
  List<RegistrationVehicles> get listvehicles => _listvehicles;

  Future<void> insert() async {
    final registrationVehicles = RegistrationVehicles(
      model: controllermodel.text,
      plate: controllerplate.text,
      brand: controllerbrand.text,
      builtYear: int.parse(controllerbuiltYear.text),
      vehicleYear: int.parse(controllervehicleYear.text),
      vehiclephoto: controllervehiclephoto.text,
      pricePaid: controllerpricePaid
          .text, //double.parse(controllerpricePaid as String),
      purchasedWhen: controllerpurchasedWhen
          .text, //DateTime(controllerpurchasedWhen as int),
      dealershipId: 1,
    );

    await controller.insert(registrationVehicles);
    await load();

    controllermodel.clear();
    controllerplate.clear();
    controllerbrand.clear();
    controllerbuiltYear.clear();
    controllervehiclephoto.clear();
    controllerpricePaid.clear();
    controllerpurchasedWhen.clear();
    controllervehicleYear.clear();
    controllerdealershipId.clear();

    notifyListeners();
  }

  Future<void> delete(RegistrationVehicles registrationVehicles) async {
    await controller.delete(registrationVehicles);
    await load();

    notifyListeners();
  }

  Future<void> load() async {
    final list = await controller.select();
    listvehicles.clear();
    listvehicles.addAll(list);

    notifyListeners();
  }

  void editSearch(RegistrationVehicles registrationVehicles) {
    _controllermodel.text = registrationVehicles.model;
    _controllerbrand.text = registrationVehicles.brand;

    /* _registeratual = RegistrationVehicles(
      model: registrationVehicles.model,
      brand: registrationVehicles.brand,
      plate: registrationVehicles.plate,
      builtYear: registrationVehicles.builtYear,
      vehiclephoto: registrationVehicles.vehiclephoto,
      pricePaid: registrationVehicles.pricePaid,
      purchasedWhen: registrationVehicles.purchasedWhen,
      vehicleYear: registrationVehicles.vehicleYear,
      dealershipId: registrationVehicles.dealershipId,
    );*/
    //  id: registrationVehicles.id) as RegisterVehicles?;

    // print(_registeratual?.id);
    //  print(_registeratual?.cnpj);
    // print(_registeratual?.name);
  }

  Future<void> update() async {
    final registroEditado = RegistrationVehicles(
      // dealershipId: _registeratual?,
      model: controllermodel.text,
      brand: controllerbrand.text,
    );

    await controller.update(registroEditado);
    _registeratual = null;
    _controllermodel.clear();
    _controllermodel.clear();

    await load();
  }
}

class RegisterVehicles extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegistroStateVeiculos(),
      child: Consumer<RegistroStateVeiculos>(
        builder: (_, state, __) {
          return Center(
            child: Scaffold(
              appBar: BarraSuperior(),
              drawer: const DrawerMenu(),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: state._controllermodel,
                              decoration: InputDecoration(
                                labelText: 'Modelo',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: state._controllerplate,
                              decoration: InputDecoration(
                                labelText: 'N*Placa',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: state._controllerbrand,
                              decoration: InputDecoration(
                                labelText: 'marca',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: state._controllerbuiltYear,
                              decoration: InputDecoration(
                                labelText: 'ano de fabricação',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: state._controllervehicleYear,
                              decoration: InputDecoration(
                                labelText: 'ano do veículo',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: state._controllervehiclephoto,
                              decoration: InputDecoration(
                                labelText: 'foto do veículo',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: state.controllerpricePaid,
                              decoration: InputDecoration(
                                labelText: 'preço pago pela loja',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: state.controllerpurchasedWhen,
                              decoration: InputDecoration(
                                labelText: 'data da compra',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100)),
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
          );
        },
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({Key? key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RegistroStateVeiculos>(context);

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
