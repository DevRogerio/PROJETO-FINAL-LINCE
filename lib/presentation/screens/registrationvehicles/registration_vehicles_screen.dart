import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import '../../../generated/l10n.dart';
import '../../state/registerstore/register_store_state.dart';
import '../../state/registrationvehicle/registration_vehicle_state.dart';
import '../../utils/utils/app_bar.dart';
import '../../utils/utils/autocomplete_.dart';
import '../../utils/utils/menu.dart';
import '../../utils/utils/small_button.dart';

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
                                controller: state.controllerplate,
                                decoration: InputDecoration(
                                  labelText: Inter.current.plate,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: state.controllerbuiltYear,
                                decoration: InputDecoration(
                                  labelText: Inter.current.builtYear,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: state.controllervehicleYear,
                                decoration: InputDecoration(
                                  labelText: Inter.current.vehicleYear,
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
                                  labelText: Inter.current.pricePaid,
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
                                  labelText: Inter.current.purchasedWhen,
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
            child: Text(Inter.current.register),
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
          text: Inter.current.gallery,
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
