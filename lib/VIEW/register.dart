import 'package:carros_car/CONTROLLER/RegisterStore_repository.dart';
import 'package:carros_car/MODEL/RegisterStore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistroState extends ChangeNotifier {
  final controller = RegisterController();
  final _controllerName = TextEditingController();
  final _controllerid = TextEditingController();
  final _controllercnpj = TextEditingController();
  final _controllerautonomyLevelID = TextEditingController();
  final _controllerpassword = TextEditingController();

  TextEditingController get controllerName => _controllerName;
  TextEditingController get controllerid => _controllerid;
  TextEditingController get controllercnpj => _controllercnpj;
  TextEditingController get controllerautonomyLevelID =>
      _controllerautonomyLevelID;
  TextEditingController get controllerpassword => _controllerpassword;

  Future<void> insert() async {
    final registerStore = RegisterStore(
        name: _controllerName.text,
        id: int.parse(_controllerid.text),
        cnpj: int.parse(_controllercnpj.text),
        autonomyLevelID: _controllerautonomyLevelID.text,
        password: _controllerpassword.text);

    await controller.insert(registerStore);

    controllerName.clear();
    notifyListeners();
  }
}

class register extends StatelessWidget {
  register({
    Key? key,
  }) : super(key: key);
  final dropValue = ValueNotifier('');
  final dropOpcoes = [
    'loja Iniciante 74% - rede 25%',
    'loja Intermediario 79% - rede 20%',
    'loja Avançado 84% - rede 15%',
    'loja Especial 94% - rede 5%'
  ];
  var idController = TextEditingController();

  var CNPJController = TextEditingController();
  var nomeLojaController = TextEditingController();
  var nivelDeAutonomiaController = TextEditingController();
  var SenhaController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  void dispose() {
    idController.dispose();
    CNPJController.dispose();
    nomeLojaController.dispose();
    nivelDeAutonomiaController.dispose();
    SenhaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegistroState(),
      child: Consumer<RegistroState>(
        builder: (_, state, __) {
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 33, 7, 182),
            appBar: AppBar(
              backgroundColor: Color.fromARGB(235, 228, 14, 14),
              title: Center(
                child: (Text('Cadastre sua Loja')),
              ),
            ),
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.length <= 14) {
                                return "O CNPJ é curto demais";
                              } else if (!value.contains('')) {
                                return "Esse CNPJ parece estranho";
                              }
                              return null;
                            },
                            controller: CNPJController,
                            decoration: InputDecoration(
                              labelText: 'Documento(CNPJ com 14 digitos)',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.length < 2) {
                                return "O nome da loja é curto demais";
                              } else if (!value.contains('')) {
                                return "nome invalido";
                              }
                              return null;
                            },
                            controller: nomeLojaController,
                            decoration: InputDecoration(
                              labelText: 'Nome Da Loja',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ValueListenableBuilder(
                            valueListenable: dropValue,
                            builder: ((context, String value, _) {
                              return DropdownButtonFormField<String>(
                                icon: const Icon(Icons.drive_eta),
                                hint:
                                    const Text('Escolha o Nivel de Autonomia'),
                                decoration: InputDecoration(
                                    label: const Text('Nivel de Autonomia'),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
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
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.length < 5) {
                                return "Senha curta demais";
                              } else if (!value.contains('')) {
                                return "Senha deve conter no minimo 5 caracteres";
                              }
                              return null;
                            },
                            controller: SenhaController,
                            decoration: InputDecoration(
                              labelText: 'Senha',
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
