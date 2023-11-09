import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../generated/l10n.dart';

/// appBar
class BarraSuperior extends AppBar {
  /// appBar
  BarraSuperior({super.key})
      : super(
            backgroundColor: Colors.black,
            automaticallyImplyLeading:
                false, //esconder o icone original do menu
            centerTitle: true,
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: const FaIcon(FontAwesomeIcons.bars),
                  //abrir o menu
                  onPressed: () => Scaffold.of(context).openDrawer(),
                );
              },
            ),
            //titulo
            title: Text(
              Inter.current.AndersonCars,
              style: TextStyle(color: Colors.red.shade600, fontSize: 30),
            ),
            //icone do Menu
            iconTheme: IconThemeData(color: Colors.red.shade600));
}
