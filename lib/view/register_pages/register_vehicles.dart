import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../MODEL/register_store.dart';
import '../../MODEL/registration_vehicles.dart';
import '../../controllers/database.dart';
import '../../controllers/fipe_api.dart';
import '../utils/app_bar.dart';
import '../utils/autocomplete_.dart';
import '../utils/menu.dart';
import '../utils/small_button.dart';
import 'register.dart';

/// RegistroStateVeiculos Record Management
class RegistroStateVeiculos extends ChangeNotifier {
  /// Constructs a stateVeiculos registry instance
  RegistroStateVeiculos(this.user) {
    init();
    unawaited(load(user!.id!));
  }

  ///user
  final RegisterStore? user;

  /// controller of RegistrationVehiclesController
  final controller = RegistrationVehiclesController();

  final _controlleruserID = TextEditingController();
  final _controllerModel = TextEditingController();
  final _controllerplate = TextEditingController();
  final _controllerbrand = TextEditingController();
  final _controllerbuiltYear = TextEditingController();
  final _controllervehicleYear = TextEditingController();
  final _controllerpricePaid = TextEditingController();
  final _controllerpurchasedWhen = TextEditingController();
  RegistrationVehicles? _registeratual;
  final _listvehicles = <RegistrationVehicles>[];
  String? _controllervehiclephoto;

  /// Manage userID information
  TextEditingController get controlleruserID => _controlleruserID;

  /// Manage Model information
  TextEditingController get controllerModel => _controllerModel;

  /// Manage plate information
  TextEditingController get controllerplate => _controllerplate;

  /// Manage brand information
  TextEditingController get controllerbrand => _controllerbrand;

  /// Manage builtYear information
  TextEditingController get controllerbuiltYear => _controllerbuiltYear;

  /// Manage vehicleYear information
  TextEditingController get controllervehicleYear => _controllervehicleYear;

  /// Manage pricePaid information
  TextEditingController get controllerpricePaid => _controllerpricePaid;

  /// Manage purchasedWhen information
  TextEditingController get controllerpurchasedWhen => _controllerpurchasedWhen;

  /// var editing
  RegistrationVehicles? get registeratual => _registeratual;

  /// list vehicles
  List<RegistrationVehicles> get listvehicles => _listvehicles;

  /// var photo
  String? get controllervehiclephoto => _controllervehiclephoto;

  /// Model shown in the field
  final modelFieldFocusNode = FocusNode();

  /// brands
  final allBrands = <String>[];

  /// models
  final allModels = <String>[];

  /// method init by models and brands
  void init() async {
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

  /// method by brands
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

  /// method by models
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

  /// method insert
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
        userID: user!.id!,
        purchasedWhen:
            DateFormat('dd/MM/yyyy').parse(controllerpurchasedWhen.text));

    await controller.insert(registrationVehicles);
    await load(user!.id!);

    controllerModel.clear();
    controllerplate.clear();
    controllerbrand.clear();
    controllerbuiltYear.clear();
    controllerpricePaid.clear();
    controllerpurchasedWhen.clear();
    controllervehicleYear.clear();
    controlleruserID.clear();

    notifyListeners();
  }

  /// method delete
  Future<void> delete(RegistrationVehicles registrationVehicles) async {
    await controller.delete(registrationVehicles);
    await load(user!.id!);

    notifyListeners();
  }

  /// method load
  Future<void> load(int id) async {
    final list = <RegistrationVehicles>[];
    if (user!.id != 1) {
      list.addAll(await controller.selectByCars(id));
    } else {
      list.addAll(await controller.selectAll());
    }

    listvehicles.clear();
    listvehicles.addAll(list);

    notifyListeners();
  }

  /// method edit
  void editSearchVehicles(RegistrationVehicles registrationVehicles) {
    _controllerModel.text = registrationVehicles.model;
    _controllerbrand.text = registrationVehicles.brand.toString();
    _controllerplate.text = registrationVehicles.plate;
    _controllerbuiltYear.text = registrationVehicles.builtYear.toString();
    _controllervehicleYear.text = registrationVehicles.vehicleYear.toString();
    _controllervehiclephoto = registrationVehicles.vehiclephoto!;
    _controllerpricePaid.text = registrationVehicles.pricePaid.toString();
    _controlleruserID.text = registrationVehicles.toString();
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
        userID: user!.id!,
        id: registrationVehicles.id);
  }

  /// method update
  Future<void> update() async {
    final registroEditado = RegistrationVehicles(
      id: _registeratual?.id,
      model: controllerModel.text,
      plate: controllerplate.text,
      brand: controllerbrand.text,
      builtYear: int.parse(controllerbuiltYear.text),
      vehicleYear: int.parse(controllervehicleYear.text),
      vehiclephoto: controllervehiclephoto,
      pricePaid: double.parse(controllerpricePaid.text),
      userID: user!.id!,
      purchasedWhen: DateTime.parse(controllerpurchasedWhen.text),
    );

    await controller.update(registroEditado);
    _registeratual = null;
    _controllerModel.clear();
    _controllerplate.clear();
    _controllerbrand.clear();
    _controllerbuiltYear.clear();
    _controllerpricePaid.clear();
    _controllerpurchasedWhen.clear();
    _controllervehicleYear.clear();
    _controlleruserID.clear();

    await load(user!.id!);
  }

  /// Method Grab Image From Gallery
  Future pickImage() async {
    {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      _controllervehiclephoto = image.path;
    }
    notifyListeners();
  }

  /// method take photo
  Future takePhoto() async {
    {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      _controllervehiclephoto = image.path;
      notifyListeners();
    }
  }
}

/// Screen of RegisterVehicles
class RegisterVehicles extends StatelessWidget {
  /// class of RegisterVehicles
  RegisterVehicles({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mainState = Provider.of<RegistroState>(context);
    return ChangeNotifierProvider(
      create: (context) => RegistroStateVeiculos(mainState.logUser),
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
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  labelText: 'preço pago pela loja',
                                  hintText: '\$ 00.000',
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