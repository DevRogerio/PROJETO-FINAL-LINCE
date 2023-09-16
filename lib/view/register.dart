import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../MODEL/register_store.dart';
import '../controllers/database.dart';
import 'utils/app_bar.dart';
import 'utils/menu.dart';

class RegistroState extends ChangeNotifier {
  RegistroState() {
    load();
  }

  String registerStoreName = 'nome';

  int? registerStorecnpj;

  final _listUser = <RegisterStore>[];
  final _formKey = GlobalKey<FormState>();

  final controller = RegisterController();
  final _controllerCNPJ = TextEditingController();
  final _controllerName = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerAutonomyLevelID = TextEditingController();

  RegisterStore? _registerAtual;

  TextEditingController get controllerName => _controllerName;

  TextEditingController get controllerCNPJ => _controllerCNPJ;

  TextEditingController get controllerAutonomyLevelID =>
      _controllerAutonomyLevelID;

  TextEditingController get controllerPassword => _controllerPassword;

  RegisterStore? get registerAtual => _registerAtual;

  List<RegisterStore> get listUser => _listUser;

  GlobalKey<FormState> get formKey => _formKey;

  Future<void> insert() async {
    final registerStore = RegisterStore(
      name: controllerName.text,
      // id: int.parse(_controllerid.text),
      cnpj: int.parse(controllerCNPJ.text),
      autonomyLevelID: controllerAutonomyLevelID.text,
      password: controllerPassword.text,
    );

    await controller.insert(registerStore);
    await load();

    controllerName.clear();
    controllerCNPJ.clear();
    controllerAutonomyLevelID.clear();
    controllerPassword.clear();

    notifyListeners();
  }

  Future<void> delete(RegisterStore registerStore) async {
    await controller.delete(registerStore);
    await load();

    notifyListeners();
  }

  Future<void> load() async {
    final list = await controller.select();
    listUser.clear();
    listUser.addAll(list);

    notifyListeners();
  }

  void editSearch(RegisterStore registerStore) {
    _controllerName.text = registerStore.name;
    _controllerCNPJ.text = registerStore.cnpj.toString();

    _registerAtual = RegisterStore(
        name: registerStore.name,
        cnpj: registerStore.cnpj,
        password: registerStore.password,
        autonomyLevelID: registerStore.autonomyLevelID,
        id: registerStore.id);
  }

  Future<void> update() async {
    final registroEditado = RegisterStore(
        id: _registerAtual?.id,
        name: controllerName.text,
        password: controllerPassword.text,
        autonomyLevelID: controllerAutonomyLevelID.text,
        cnpj: int.parse(controllerCNPJ.text));

    await controller.update(registroEditado);
    _registerAtual = null;
    _controllerPassword.clear();
    _controllerAutonomyLevelID.clear();
    _controllerName.clear();
    _controllerCNPJ.clear();

    await load();
  }

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
  }
}

class Register extends StatelessWidget {
  Register({
    Key? key,
  }) : super(key: key);
  final dropValue = ValueNotifier('');
  final dropOpcoes = [
    'loja Iniciante 74% - rede 25%',
    'loja Intermediario 79% - rede 20%',
    'loja Avançado 84% - rede 15%',
    'loja Especial 94% - rede 5%'
  ];

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
                            child: ValueListenableBuilder(
                              valueListenable: dropValue,
                              builder: ((context, value, _) {
                                return DropdownButtonFormField<String>(
                                  icon: const Icon(Icons.drive_eta),
                                  hint: const Text(
                                      'Escolha o Nivel de Autonomia'),
                                  decoration: InputDecoration(
                                      label: const Text('Nivel de Autonomia'),
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
