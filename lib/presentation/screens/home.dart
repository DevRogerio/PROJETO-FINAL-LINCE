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

                    SizedBox(
                      width: size.width * 0.90,
                      height: size.height * 0.50,
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
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                          width: 15, color: Colors.black),
                                    ),
                                  ),
                                ),
                                child: Container(
                                  width: size.width / 1.3,
                                  height: size.height / 5,
                                  padding: const EdgeInsets.all(25),
                                  color: const Color.fromARGB(255, 4, 39, 92),
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
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(
                                    width: 15, color: Colors.black),
                              ),
                            ),
                          ),
                          child: Container(
                            width: size.width / 1.3,
                            height: size.height / 5,
                            padding: const EdgeInsets.all(25),
                            color: const Color.fromARGB(255, 4, 39, 92),
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
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(
                                    width: 15, color: Colors.black),
                              ),
                            ),
                          ),
                          child: Container(
                            width: size.width / 1.3,
                            height: size.height / 5,
                            padding: const EdgeInsets.all(25),
                            color: const Color.fromARGB(255, 4, 39, 92),
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
