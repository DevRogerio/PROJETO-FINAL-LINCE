import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../state/registerstore/register_store_state.dart';
import '../../utils/utils/app_bar.dart';
import '../../utils/utils/menu.dart';
import 'edit_perfil_search.dart';

/// Screen of Search
class Search extends StatelessWidget {
  /// class of Search
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => RegistroState(),
      child: Consumer<RegistroState>(
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
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 75),
                itemCount: state.listUser.length,
                itemBuilder: (context, index) {
                  final registerStoreTable = state.listUser[index];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 1, vertical: 25),
                    width: size.width,
                    height: size.height * 0.15,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        Color(0xffF99E43),
                        Color(0xFFDA2323),
                      ],
                    )),
                    child: Card(
                      elevation: 50,
                      child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                          colors: [
                            Color(0xffF99E43),
                            Color(0xFFDA2323),
                          ],
                        )),
                        child: ListTile(
                          leading: Text(registerStoreTable.id.toString()),
                          title: Text(registerStoreTable.name.toString()),
                          subtitle: Text(registerStoreTable.cnpj.toString()),
                          trailing: IntrinsicWidth(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await state.delete(registerStoreTable);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 25,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    state.editSearch(registerStoreTable);
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ChangeNotifierProvider.value(
                                          value: state,
                                          child: const EditPerfilSearch(),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    // ignore: deprecated_member_use
                                    FontAwesomeIcons.chevronCircleRight,
                                    color: state.ligthMode
                                        ? Colors.black
                                        : Colors.white,
                                    size: 35,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await Navigator.of(context).pushNamed(
                                        'Autonomyedite',
                                        arguments: registerStoreTable);
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
