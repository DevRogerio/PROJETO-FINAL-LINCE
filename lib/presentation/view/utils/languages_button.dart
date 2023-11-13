import 'dart:async';

import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class LanguagesButton extends StatefulWidget {
  const LanguagesButton({super.key});

  @override
  State<LanguagesButton> createState() => _LanguagesButtonState();
}

class _LanguagesButtonState extends State<LanguagesButton> {
  bool isPortuguese = false;

  void changeLang() {
    setState(() {
      if (isPortuguese) {
        unawaited(Inter.load(Locale('en')));
        isPortuguese = false;
      } else {
        unawaited(Inter.load(Locale('pt', 'BR')));
        isPortuguese = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              changeLang;
            });
          }),
    );
  }
}
