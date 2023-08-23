import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BarraSuperior extends AppBar {
  BarraSuperior()
      : super(
            automaticallyImplyLeading:
                false, //esconder o icone original do menu
            centerTitle: true,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: FaIcon(FontAwesomeIcons.bars),
                  //abrir o menu
                  onPressed: () => Scaffold.of(context).openDrawer(),
                );
              },
            ),
            //titulo
            title: Text(
              'Anderson Carros',
              style: TextStyle(color: Colors.red.shade600, fontSize: 30),
            ),
            //icone do Menu
            iconTheme: IconThemeData(color: Colors.red.shade600));
}
