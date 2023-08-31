import 'package:carros_car/VIEW/funcionalidades/AppBar.dart';
import 'package:carros_car/VIEW/funcionalidades/menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //titulo do app
        appBar: BarraSuperior(),

        // Menu
        drawer: DrawerMenu(),

        //Corpo do app
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Text(
                      "Olá Anderson, o que vamos fazer?",
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 45),

                    //botao ver lojas
                    Builder(
                      builder: (BuildContext context) {
                        return ElevatedButton(
                          child: Container(
                            width: 300,
                            padding: const EdgeInsets.all(16),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FaIcon(
                                  // ignore: deprecated_member_use
                                  FontAwesomeIcons.search,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                Text(
                                  "Buscar Lojas",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                )
                              ],
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              // ignore: deprecated_member_use
                              primary: Colors.red.shade900),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    //botao ver veiculos
                    Builder(
                      builder: (BuildContext context) {
                        return ElevatedButton(
                          child: Container(
                            width: 300,
                            padding: const EdgeInsets.all(16),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FaIcon(
                                  // ignore: deprecated_member_use
                                  FontAwesomeIcons.car,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                Text(
                                  "Buscar Veiculos",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                )
                              ],
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              // ignore: deprecated_member_use
                              primary: Colors.blue.shade900),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()),
                            );
                          },
                        );
                      },
                    ),

                    //botao ver vendas
                    const SizedBox(height: 20),

                    Builder(
                      builder: (BuildContext context) {
                        return ElevatedButton(
                          child: Container(
                            width: 300,
                            padding: const EdgeInsets.all(16),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FaIcon(
                                  // ignore: deprecated_member_use
                                  FontAwesomeIcons.dollarSign,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                Text(
                                  "Vendas Realizadas",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                )
                              ],
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              // ignore: deprecated_member_use
                              primary: Colors.green.shade900),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
