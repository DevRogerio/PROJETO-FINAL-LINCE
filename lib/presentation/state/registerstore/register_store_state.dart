import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../entities/register_store.dart';
import '../../../repository/database/database.dart';
import '../../../repository/database/register_store_table.dart';
import '../../../usecases/register_store__table_controller.dart';

/// Defines a constant variable named [appThemeModeKey] and assigns a string.
const appThemeModeKey = 'appThemeMode';

/// Shared preferences key to the app language.
const appLanguageKey = 'appLanguageKey';

/// RegistroState Record Management
class RegistroState extends ChangeNotifier {
  /// Constructs a state registry instance
  RegistroState() {
    unawaited(load());
    unawaited(loadUser());
    unawaited(_init());
  }
  late final SharedPreferences _sharedPreferences;

  var _lightMode = false;

  /// Defines a getter method that allows you to access
  /// the value of the _lightMode.
  bool get ligthMode => _lightMode;

  /// This variable can be used to track whether something is currently
  /// in a [loading] state,
  bool loading = true;

  var _language = 'en';

  /// The selected language of the app.
  String? get language => _language;

  RegisterStore? _logUser;

  /// current user logged
  RegisterStore? get logUser => _logUser;

  /// store name
  String registerStoreName = '';

  /// store cnpj
  int? registerStorecnpj;

  final _listUser = <RegisterStore>[];
  final _formKey = GlobalKey<FormState>();

  /// controller of RegisterController
  final controller = RegisterController();
  final _controllerCNPJ = TextEditingController();
  final _controllerName = TextEditingController();
  final _controllerPassword = TextEditingController();

  RegisterStore? _registerAtual;

  /// Manage name information
  TextEditingController get controllerName => _controllerName;

  /// Manage CNPJ information

  TextEditingController get controllerCNPJ => _controllerCNPJ;

  /// Manage Password information
  TextEditingController get controllerPassword => _controllerPassword;

  /// var editing
  RegisterStore? get registerAtual => _registerAtual;

  /// list user
  List<RegisterStore> get listUser => _listUser;

  /// formkey
  GlobalKey<FormState> get formKey => _formKey;

  /// method insert
  Future<void> insert() async {
    final registerStore = RegisterStore(
      name: controllerName.text,
      cnpj: int.parse(controllerCNPJ.text),
      password: controllerPassword.text,
    );

    await controller.insert(registerStore);
    await load();

    controllerName.clear();
    controllerCNPJ.clear();

    controllerPassword.clear();

    notifyListeners();
  }

  /// method delete
  Future<void> delete(RegisterStore registerStore) async {
    await controller.delete(registerStore);
    await load();

    notifyListeners();
  }

  /// method load
  Future<void> load() async {
    final list = await controller.select();
    listUser.clear();
    listUser.addAll(list);

    notifyListeners();
  }

  /// method edit
  void editSearch(RegisterStore registerStore) {
    _controllerName.text = registerStore.name!;
    _controllerCNPJ.text = registerStore.cnpj.toString();
    _controllerPassword.text = registerStore.password!;

    _registerAtual = RegisterStore(
        name: registerStore.name,
        cnpj: registerStore.cnpj,
        password: registerStore.password,
        id: registerStore.id);
  }

  /// method update
  Future<void> update() async {
    final registroEditado = RegisterStore(
        id: _registerAtual?.id,
        name: controllerName.text,
        password: controllerPassword.text,
        cnpj: int.parse(controllerCNPJ.text));

    await controller.update(registroEditado);
    _registerAtual = null;
    _controllerPassword.clear();

    _controllerName.clear();
    _controllerCNPJ.clear();

    await load();
  }

  /// method login by name
  Future<dynamic> getRegisterStore(String name) async {
    final database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(
      RegisterStoreTable.tableName,
      where: '${RegisterStoreTable.name} = ?',
      whereArgs: [name],
    );

    if (result.isNotEmpty) {
      final item = result.first;

      return RegisterStore(
        id: item[RegisterStoreTable.id],
        cnpj: item[RegisterStoreTable.cnpj],
        name: item[RegisterStoreTable.name],
        password: item[RegisterStoreTable.password],
      );
    }
    notifyListeners();
    return null;
  }

  /// method save user SharedPreferences
  Future<void> savedUser(int userid, String username) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt('userid', userid);
    await preferences.setString('username', username);
  }

  /// method load user SharedPreferences
  Future<void> loadUser() async {
    final preferences = await SharedPreferences.getInstance();
    final userid = preferences.getInt('userid');
    final username = preferences.getString('username');
    if (userid != null && username != null) {
      _logUser = RegisterStore(name: username, id: userid);
    }
    notifyListeners();
  }

  /// method clear SharedPreferences
  Future<void> clearPreferences() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  ///method random password
  void gerarSenha() {
    var caracteres =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    var senha = '';

    for (var i = 0; i < 4; i++) {
      var indice = random.nextInt(caracteres.length);
      senha += caracteres[indice];
    }
    _controllerPassword.text = senha;

    return;
  }

  /// Used to toggle between two theme modes (light and dark).
  /// It saves the current theme mode
  /// to persistent storage using SharedPreferences.
  Future<void> toggleTheme() async {
    _lightMode = !_lightMode;
    await _sharedPreferences.setBool(appThemeModeKey, _lightMode);
    notifyListeners();
  }

  /// Changes the [_language] value to the given [language].
  Future<void> toggleLanguage({String? language}) async {
    _language = _language;
    await _sharedPreferences.setString(appLanguageKey, _language);
    notifyListeners();
  }

  Future<void> _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _lightMode = _sharedPreferences.getBool(appThemeModeKey) ?? false;
    _language = _sharedPreferences.getString(appLanguageKey) ?? 'en';
    notifyListeners();
  }
}
