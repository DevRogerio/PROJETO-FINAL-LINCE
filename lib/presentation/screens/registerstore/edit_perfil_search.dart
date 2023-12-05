import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/l10n.dart';
import '../../state/registerstore/register_store_state.dart';
import '../../utils/utils/app_bar.dart';
import '../../utils/utils/menu.dart';
import 'register_list_screen.dart';

/// Screen of EditPerfilSearch
class EditPerfilSearch extends StatelessWidget {
  /// class of EditPerfilSearch
  const EditPerfilSearch({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<RegistroState>(
      builder: (_, state, __) {
        return Scaffold(
          backgroundColor: state.ligthMode ? Colors.white : Colors.black,
          appBar: BarraSuperior(),
          drawer: const DrawerMenu(),
          body: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: state.ligthMode ? Colors.white : Colors.black,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                padding: const EdgeInsets.all(16),
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  color: state.ligthMode ? Colors.white : Colors.black,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: state.controllerName,
                          decoration: InputDecoration(
                            label: Text(Inter.current.name),
                            labelStyle: const TextStyle(color: Colors.red),
                          ),
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return 'não pode estar vazio';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: state.controllerPassword,
                          decoration: InputDecoration(
                            label: Text(Inter.current.Password),
                            labelStyle: const TextStyle(color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: state.controllerCNPJ,
                          decoration: const InputDecoration(
                            label: Text(' cnpj'),
                            labelStyle: TextStyle(color: Colors.red),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade900),
                          onPressed: () async {
                            if (state.registerAtual != null) {
                              state.editSearch;
                              await state.update();
                            } else {
                              await state.insert();
                            }

                            if (context.mounted) {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Search(),
                                ),
                              );
                            }
                          },
                          child: Text(Inter.current.update),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
