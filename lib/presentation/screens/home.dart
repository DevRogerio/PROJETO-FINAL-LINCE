import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../generated/l10n.dart';
import '../state/registerstore/register_store_state.dart';
import '../utils/utils/app_bar.dart';
import '../utils/utils/carousel.dart';
import '../utils/utils/menu.dart';
import 'registerstore/register_list_screen.dart';
import 'registrationvehicles/registration_vehicle_list.dart';
import 'sale/sales_list_screen.dart';

/// Screen of Home
class Home extends StatelessWidget {
  /// class of Home
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
          decoration: BoxDecoration(
            color: state.ligthMode ? Colors.white : Colors.black,
          ),
          child: Column(
            children: [
              const Carousel(),
              const SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                  color: state.ligthMode ? Colors.white : Colors.black,
                ),
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
                                      borderRadius: BorderRadius.circular(30),
                                      side: const BorderSide(
                                        width: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(28),
                                  child: Container(
                                    width: size.width * 0.70,
                                    height: size.height * 0.30,
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                      colors: [
                                        Color(0xffF99E43),
                                        Color(0xFFDA2323),
                                      ],
                                    )),
                                    padding: const EdgeInsets.all(35),
                                    margin: const EdgeInsets.all(1),
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
                                              color: Colors.white,
                                              fontSize: 24),
                                        )
                                      ],
                                    ),
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
                                borderRadius: BorderRadius.circular(30),
                                side: const BorderSide(
                                  width: 16,
                                ),
                              ),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: Container(
                              width: size.width * 0.70,
                              height: size.height * 0.30,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 214, 165, 115),
                                  Color(0xFFDA2323),
                                ],
                              )),
                              padding: const EdgeInsets.all(25),
                              margin: const EdgeInsets.all(1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                borderRadius: BorderRadius.circular(30),
                                side: const BorderSide(
                                  width: 16,
                                ),
                              ),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: Container(
                              width: size.width * 0.70,
                              height: size.height * 0.30,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 211, 202, 192),
                                  Color.fromARGB(255, 163, 16, 16),
                                ],
                              )),
                              padding: const EdgeInsets.all(25),
                              margin: const EdgeInsets.all(1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: state.ligthMode ? Colors.white : Colors.black,
        animationDuration: const Duration(milliseconds: 700),
        items: [
          Icon(
            Icons.home,
            color: Colors.deepOrange.shade900,
          ),
          Icon(
            Icons.directions_car,
            color: Colors.amber.shade900,
          ),
          Icon(
            Icons.settings,
            color: Colors.indigo.shade900,
          ),
        ],
      ),
    );
  }
}
