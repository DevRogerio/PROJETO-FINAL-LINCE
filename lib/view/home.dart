import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'register_pages/register.dart';
import 'search_pages/search_register.dart';
import 'search_pages/search_sale.dart';
import 'search_pages/search_vehicles.dart';
import 'utils/app_bar.dart';
import 'utils/carousel.dart';
import 'utils/menu.dart';

/// Screen of Home
class Home extends StatelessWidget {
  /// class of Home
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RegistroState>(
      context,
    );
    final userid = state.logUser!.id;

    return Scaffold(
      //titulo do app
      appBar: BarraSuperior(),

      // Menu
      drawer: const DrawerMenu(),

      //Corpo do app
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.black,
            Colors.black,
            Colors.black,
            Colors.black,
            Colors.black,
            Colors.black,
          ])),
          child: Column(
            children: [
              const Carousel(),
              const SizedBox(
                height: 25,
              ),
              Container(
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
                alignment: Alignment.center,
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    userid == 1
                        ? Text(
                            'Olá Anderson, o que vamos fazer?',
                            style: TextStyle(
                              color: Colors.grey.shade300,
                              fontSize: 24,
                            ),
                          )
                        : Container(),
                    const SizedBox(height: 45),

                    SizedBox(
                      height: 250,
                      width: 700,
                      child: Image.asset('assets/img/loogo.jpg'),
                    ),
                    const SizedBox(height: 10),

                    //botao ver lojas
                    userid == 1
                        ? Builder(
                            builder: (context) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    // ignore: deprecated_member_use
                                    primary: Colors.red.shade900),
                                onPressed: () async {
                                  if (userid == 1) {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Search()),
                                    );
                                  }
                                },
                                child: Container(
                                  width: 300,
                                  padding: const EdgeInsets.all(16),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FaIcon(
                                        // ignore: deprecated_member_use
                                        FontAwesomeIcons.search,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      Text(
                                        'Buscar Lojas',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 24),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(
                            height: 100,
                          ),
                    const SizedBox(height: 20),

                    //botao ver veiculos
                    Builder(
                      builder: (context) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              // ignore: deprecated_member_use
                              primary: Colors.red.shade900),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SearchVehicles(),
                              ),
                            );
                          },
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
                                  'Buscar Veiculos',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    //botao ver vendas
                    const SizedBox(height: 20),

                    Builder(
                      builder: (context) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              // ignore: deprecated_member_use
                              primary: Colors.red.shade900),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SearchSale()),
                            );
                          },
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
                                  'Vendas Realizadas',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
