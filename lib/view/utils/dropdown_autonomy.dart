import 'package:flutter/material.dart';

class MenuDropDown extends StatelessWidget {
  MenuDropDown({
    Key? key,
  }) : super(key: key);
  final dropValue = ValueNotifier('');
  final dropOpcoes = [
    'loja Iniciante 74% - rede 25%',
    'loja Intermediario 79% - rede 20%',
    'loja Avançado 84% - rede 15%',
    'loja Especial 94% - rede 5%'
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ValueListenableBuilder(
        valueListenable: dropValue,
        builder: ((context, value, _) {
          return DropdownButtonFormField<String>(
            icon: const Icon(Icons.drive_eta),
            hint: const Text('Escolha o Nivel de Autonomia'),
            decoration: InputDecoration(
                label: const Text('Nivel de Autonomia'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                )),
            value: (value.isEmpty) ? null : value,
            onChanged: (escolha) => dropValue.value = escolha.toString(),
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
