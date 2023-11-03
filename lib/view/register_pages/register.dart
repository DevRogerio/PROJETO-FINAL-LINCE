import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../MODEL/register_store.dart';
import '../../controllers/database.dart';
import '../utils/app_bar.dart';
import '../utils/menu.dart';

/// RegistroState Record Management
class RegistroState extends ChangeNotifier {
  /// Constructs a state registry instance
  RegistroState() {
    unawaited(load());
    unawaited(loadUser());
  }

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

  void _gerarSenha() {
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
}

/// Screen of Register
class Register extends StatelessWidget {
  /// class of Register
  Register({
    Key? key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegistroState(),
      child: Consumer<RegistroState>(
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
                                  controller: state._controllerCNPJ,
                                  decoration: InputDecoration(
                                    labelText: 'Documento(CNPJ com 14 digitos)',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: state.controllerName,
                                  decoration: InputDecoration(
                                    labelText: 'Nome Da Loja',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: state._controllerPassword,
                                  decoration: InputDecoration(
                                    labelText: 'Senha',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red.shade900),
                                onPressed: () {
                                  state._gerarSenha();
                                },
                                child: const Text('gerar senha'),
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
    final state = Provider.of<RegistroState>(context);

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
