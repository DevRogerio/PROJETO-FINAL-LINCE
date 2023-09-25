//import 'dart:developer';

import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../MODEL/registration_vehicles.dart';
import '../controllers/database.dart';
import '../controllers/fipe_api.dart';
import 'utils/app_bar.dart';
import 'utils/autocomplete_.dart';
import 'utils/menu.dart';
import 'utils/small_button.dart';

class RegistroStateVeiculos extends ChangeNotifier {
  RegistroStateVeiculos() {
    init();
    load();
  }
  //String? registrationVehiclespricePaid;
  //String? registrationVehiclespurchasedWhen;
  final controller = RegistrationVehiclesController();

  final _controllerModel = TextEditingController();
  final _controllerplate = TextEditingController();
  final _controllerbrand = TextEditingController();
  final _controllerbuiltYear = TextEditingController();
  final _controllervehicleYear = TextEditingController();
  // final _controllervehiclephoto = TextEditingController();
  final _controllerpricePaid = TextEditingController();
  final _controllerpurchasedWhen = TextEditingController();
  // final _controllerdealershipId = TextEditingController();
  RegistrationVehicles? _registeratual;
  final _listvehicles = <RegistrationVehicles>[];
  String? _controllervehiclephoto;

  TextEditingController get controllerModel => _controllerModel;
  TextEditingController get controllerplate => _controllerplate;
  TextEditingController get controllerbrand => _controllerbrand;
  TextEditingController get controllerbuiltYear => _controllerbuiltYear;
  TextEditingController get controllervehicleYear => _controllervehicleYear;

  TextEditingController get controllerpricePaid => _controllerpricePaid;
  TextEditingController get controllerpurchasedWhen => _controllerpurchasedWhen;

  RegistrationVehicles? get registeratual => _registeratual;
  List<RegistrationVehicles> get listvehicles => _listvehicles;
  String? get controllervehiclephoto => _controllervehiclephoto;

  final modelFieldFocusNode = FocusNode();
  final allBrands = <String>[];
  final allModels = <String>[];

  void init() async {
    //  _loggedUser = user;

    final result = await getBrandNames();

    allBrands.addAll(result ?? []);

    modelFieldFocusNode.addListener(
      () async {
        if (modelFieldFocusNode.hasFocus) {
          final result = await getModelsByBrand(controllerbrand.text);
          allModels.addAll(result!);
          notifyListeners();
        }
      },
    );
  }

  Future<List<String>?> getBrandNames() async {
    final brandsList = await getCarBrands();

    final brandNames = <String>[];

    if (brandsList != null) {
      for (final item in brandsList) {
        brandNames.add(item.name!);
      }
    }
    return brandNames;
  }

  Future<List<String>?> getModelsByBrand(String brand) async {
    final modelsList = await getCarModel(brand);

    final modelNames = <String>[];

    if (modelsList != null) {
      for (final item in modelsList) {
        modelNames.add(item.name!);
      }
    }
    return modelNames;
  }

  Future<void> insert() async {
    (controllervehiclephoto);
    final registrationVehicles = RegistrationVehicles(
        model: controllerModel.text,
        plate: controllerplate.text,
        brand: controllerbrand.text,
        builtYear: int.parse(controllerbuiltYear.text),
        vehicleYear: int.parse(controllervehicleYear.text),
        vehiclephoto: controllervehiclephoto,
        pricePaid: double.parse(controllerpricePaid.text),
        purchasedWhen:
            DateFormat('dd/MM/yyyy').parse(controllerpurchasedWhen.text)
        // dealershipId: 1,
        );

    await controller.insert(registrationVehicles);
    await load();

    controllerModel.clear();
    controllerplate.clear();
    controllerbrand.clear();
    controllerbuiltYear.clear();
    //controllervehiclephoto.clear();
    controllerpricePaid.clear();
    controllerpurchasedWhen.clear();
    controllervehicleYear.clear();
    // controllerdealershipId.clear();

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

  void editSearchVehicles(RegistrationVehicles registrationVehicles) {
    _controllerModel.text = registrationVehicles.model;
    _controllerbrand.text = registrationVehicles.brand.toString();
    _controllerplate.text = registrationVehicles.plate;
    _controllerbuiltYear.text = registrationVehicles.builtYear.toString();
    _controllervehicleYear.text = registrationVehicles.vehicleYear.toString();
    _controllervehiclephoto = registrationVehicles.vehiclephoto!;
    _controllerpricePaid.text = registrationVehicles.pricePaid.toString();
    _controllerpurchasedWhen.text =
        registrationVehicles.purchasedWhen.toString();

    _registeratual = RegistrationVehicles(
        model: registrationVehicles.model,
        brand: registrationVehicles.brand,
        plate: registrationVehicles.plate,
        builtYear: int.parse(controllerbuiltYear.text),
        vehiclephoto: registrationVehicles.vehiclephoto,
        pricePaid: double.parse(controllerpricePaid.text),
        purchasedWhen: DateTime.parse(controllerpurchasedWhen.text),
        vehicleYear: int.parse(controllervehicleYear.text),
        id: registrationVehicles.id);
    // dealershipId: registrationVehicles.dealershipId,

    //  id: registrationVehicles.id) as RegisterVehicles?;
    //  ) as RegisterVehicles;
    // print(_registeratual?.id);
    //  print(_registeratual?.cnpj);
    // print(_registeratual?.name);
  }

  Future<void> update() async {
    final registroEditado = RegistrationVehicles(
      id: _registeratual?.id,
      // dealershipId: _registeratual?,
      model: controllerModel.text,
      plate: controllerplate.text,
      brand: controllerbrand.text,
      builtYear: int.parse(controllerbuiltYear.text),
      vehicleYear: int.parse(controllervehicleYear.text),
      vehiclephoto: controllervehiclephoto,
      pricePaid: double.parse(controllerpricePaid.text),
      purchasedWhen: DateTime.parse(controllerpurchasedWhen.text),
    );

    await controller.update(registroEditado);
    _registeratual = null;
    _controllerModel.clear();
    _controllerplate.clear();
    _controllerbrand.clear();
    _controllerbuiltYear.clear();
    // controllervehiclephoto.clear();
    _controllerpricePaid.clear();
    _controllerpurchasedWhen.clear();
    _controllervehicleYear.clear();

    await load();
  }

  Future pickImage() async {
    {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      _controllervehiclephoto = image.path;
    }
    notifyListeners();
  }

  Future takePhoto() async {
    {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      _controllervehiclephoto = image.path;
      notifyListeners();
    }
  }
}

///
class RegisterVehicles extends StatelessWidget {
  ///
  RegisterVehicles({super.key});

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
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 8,
                                bottom: 8,
                              ),
                              child: _BrandTextField(),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 8,
                                bottom: 8,
                              ),
                              child: _ModelTextField(),
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
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 8,
                              ),
                              child: state.controllervehiclephoto != null
                                  ? const _PhotosList()
                                  : Container(),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 8,
                                bottom: 8,
                              ),
                              child: _ChooseOrTakePhoto(),
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
                                inputFormatters: [
                                  MaskTextInputFormatter(mask: '##/##/####')
                                ],
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
            ),
          );
        },
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton();

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

class _PhotosList extends StatelessWidget {
  const _PhotosList();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RegistroStateVeiculos>(context, listen: true);
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).focusColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.file(
                File(state.controllervehiclephoto!),
                height: MediaQuery.of(context).size.height / 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ChooseOrTakePhoto extends StatelessWidget {
  const _ChooseOrTakePhoto();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RegistroStateVeiculos>(context, listen: true);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppSmallButton(
          onPressed: state.pickImage,
          text: 'Galeria',
        ),
        AppSmallButton(
          onPressed: state.takePhoto,
          text: 'Câmera',
        )
      ],
    );
  }
}

class _BrandTextField extends StatelessWidget {
  const _BrandTextField();

  String? validator(String? value) {
    if (value!.isEmpty) {
      return "Please inform the vehicle's brand";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RegistroStateVeiculos>(context, listen: true);
    return AppTextFieldAutoComplete(
      controller: state.controllerbrand,
      validator: validator,
      suggestions: state.allBrands,
    );
  }
}

class _ModelTextField extends StatelessWidget {
  const _ModelTextField();

  String? validator(String? value) {
    if (value!.isEmpty) {
      return "Please inform the vehicle's model";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RegistroStateVeiculos>(context, listen: true);
    return AppTextFieldAutoComplete(
      controller: state.controllerModel,
      validator: validator,
      focusNode: state.modelFieldFocusNode,
      suggestions: state.allModels,
    );
  }
}
