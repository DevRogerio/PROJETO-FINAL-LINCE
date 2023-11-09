import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
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
                            Inter.current.HiAnderson,
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
                                onPressed: () async {
                                  if (userid == 1) {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Search()),
                                    );
                                  }
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      side: const BorderSide(
                                          width: 15, color: Colors.white),
                                    ),
                                  ),
                                ),
                                child: Container(
                                  width: 300,
                                  padding: const EdgeInsets.all(25),
                                  color: Colors.black,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const FaIcon(
                                        // ignore: deprecated_member_use
                                        FontAwesomeIcons.search,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      Text(
                                        Inter.current.SearchforStores,
                                        style: const TextStyle(
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
                          // style: ElevatedButton.styleFrom(
                          // ignore: deprecated_member_use
                          //  primary: Colors.red.shade900),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SearchVehicles(),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                                side: const BorderSide(
                                    width: 15, color: Colors.white),
                              ),
                            ),
                          ),
                          child: Container(
                            width: 300,
                            padding: const EdgeInsets.all(25),
                            color: Colors.black,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const FaIcon(
                                  // ignore: deprecated_member_use
                                  FontAwesomeIcons.car,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                Text(
                                  Inter.current.SearchforCars,
                                  style: const TextStyle(
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
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SearchSale()),
                            );
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                                side: const BorderSide(
                                    width: 15, color: Colors.white),
                              ),
                            ),
                          ),
                          child: Container(
                            width: 300,
                            padding: const EdgeInsets.all(25),
                            color: Colors.black,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const FaIcon(
                                  // ignore: deprecated_member_use
                                  FontAwesomeIcons.dollarSign,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                Text(
                                  Inter.current.SalesMade,
                                  style: const TextStyle(
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

/*class LanguagesButton extends StatefulWidget {
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
        onPressed: () {
          changeLang();
        },
      ),
    );
  }
}
*/