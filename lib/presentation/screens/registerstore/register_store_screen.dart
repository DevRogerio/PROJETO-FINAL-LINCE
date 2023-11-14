import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/l10n.dart';
import '../../state/registerstore/register_store_state.dart';
import '../../utils/utils/app_bar.dart';
import '../../utils/utils/menu.dart';

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
                                  controller: state.controllerCNPJ,
                                  decoration: InputDecoration(
                                    labelText: Inter.current.documentCNPJ,
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
                                    labelText: Inter.current.StoreName,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: state.controllerPassword,
                                  decoration: InputDecoration(
                                    labelText: Inter.current.passwordStore,
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
                                  state.gerarSenha();
                                },
                                child: Text(Inter.current.generatepassword),
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
            child: Text(Inter.current.register),
          )
        ],
      ),
    );
  }
}
