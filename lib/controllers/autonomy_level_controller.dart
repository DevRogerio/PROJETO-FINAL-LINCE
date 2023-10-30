import 'dart:async';

import 'package:flutter/material.dart';

import '../../controllers/database.dart';
import '../MODEL/register_store.dart';
import '../model/autonomy_level.dart';

class AutonomilevelControler extends ChangeNotifier {
  AutonomilevelControler({required this.registerStore}) {
    unawaited(loadData());
  }

  RegisterStore registerStore;

  AutonomyLevel? _autonomyCurrent;

  final controller = AutonomyControler();

  final formkey = GlobalKey<FormState>();

  final List<AutonomyLevel> _listaAutonomy = [];

  List<AutonomyLevel> get listaAutonomy => _listaAutonomy;

  final List<AutonomyLevel> _listaAutonomyComplete = [];

  List<AutonomyLevel> get listComplete => _listaAutonomyComplete;

  final _controllerNameNivel = TextEditingController();

  TextEditingController get controllerNameNivel => _controllerNameNivel;

  final _controllerNetworkSecurity = TextEditingController();

  TextEditingController get controllerNetworkSecurity =>
      _controllerNetworkSecurity;

  final _controllerStorePercentage = TextEditingController();

  TextEditingController get controllerStorePercentage =>
      _controllerStorePercentage;

  final _controllerNetworkPercentage = TextEditingController();

  TextEditingController get controllerNetworkPercentage =>
      _controllerNetworkPercentage;

  Future<void> insert() async {
    try {
      if (listaAutonomy.isNotEmpty) {
        debugPrint('Already registered!');
      } else if (registerStore.id != null) {
        final autonomy = AutonomyLevel(
          name: _controllerNameNivel.text,
          networkSecurity: double.parse(_controllerNetworkSecurity.text),
          storePercentage: double.parse(_controllerStorePercentage.text),
          networkPercentage: double.parse(_controllerNetworkPercentage.text),
          personID: registerStore.id ?? 0,
        );

        await controller.insert(autonomy);

        controllerNameNivel.clear();
        controllerNetworkPercentage.clear();
        controllerNetworkSecurity.clear();
        controllerStorePercentage.clear();

        unawaited(loadData());

        notifyListeners();
      }
    } on Exception catch (e) {
      debugPrint('Error in the insert method: $e');
    }
  }

  Future<void> loadData() async {
    final list = await controller.select(registerStore.id ?? 0);

    listaAutonomy.clear();
    listaAutonomy.addAll(list);

    notifyListeners();
  }

  void updatePerson(AutonomyLevel autonomy) {
    _controllerNameNivel.text = autonomy.name;
    _controllerNetworkPercentage.text = autonomy.networkPercentage.toString();
    _controllerNetworkSecurity.text = autonomy.networkSecurity.toString();
    _controllerStorePercentage.text = autonomy.storePercentage.toString();

    _autonomyCurrent = AutonomyLevel(
        id: autonomy.id,
        name: autonomy.name,
        networkSecurity: autonomy.networkSecurity,
        storePercentage: autonomy.storePercentage,
        networkPercentage: autonomy.storePercentage,
        personID: registerStore.id ?? 0);
    unawaited(loadData());
    notifyListeners();
  }

  Future<void> update() async {
    try {
      final autonomy = AutonomyLevel(
          id: _autonomyCurrent?.id,
          name: _controllerNameNivel.text,
          networkSecurity: double.parse(_controllerNetworkSecurity.text),
          storePercentage: double.parse(_controllerStorePercentage.text),
          networkPercentage: double.parse(_controllerNetworkPercentage.text),
          personID: registerStore.id ?? 0);

      await controller.update(autonomy);
      cleanController();
      unawaited(loadData());
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('Error in the update method: $e');
    }
  }

  void cleanController() {
    controllerNameNivel.clear();
    controllerNetworkPercentage.clear();
    controllerNetworkSecurity.clear();
    controllerStorePercentage.clear();
    unawaited(loadData());
    notifyListeners();
  }

  Future<void> delete(AutonomyLevel autonomy) async {
    try {
      await controller.delete(autonomy);
      await loadData();
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('Error in the delete method: $e');
    }
  }
}
