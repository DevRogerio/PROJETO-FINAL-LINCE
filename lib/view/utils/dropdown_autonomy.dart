import 'package:flutter/material.dart';

/// dropMenu
class DropMenu extends StatelessWidget {
  /// class of DropMenu
  DropMenu({super.key});

  ///drop value
  final dropValue = ValueNotifier('');

  ///drop opçoes
  final dropOpcoes = [
    'Iniciante 74% rede - 25% loja',
    'Intermediario 79% rede - 20% loja',
    'Avançado 84% rede - 15% loja',
    'Especial 94% rede - 5% loja'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ValueListenableBuilder(
        valueListenable: dropValue,
        builder: ((context, value, _) {
          return DropdownButtonFormField(
            icon: const Icon(Icons.drive_eta),
            hint: const Text('Escolha o Nivel de Autonomia'),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            value: (value.isEmpty) ? null : value,
            onChanged: (choose) => dropValue.value = choose.toString(),
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
    );
  }
}
