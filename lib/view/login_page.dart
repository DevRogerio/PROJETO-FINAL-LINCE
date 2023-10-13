import 'package:flutter/material.dart';

import 'home.dart';
import 'register_pages/register.dart';

/// Screen of Login
class LoginPage extends StatelessWidget {
  /// class of Login
  const LoginPage(this.state, {super.key});

  /// state of RegistroState
  final RegistroState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'Anderson Carros',
            style: TextStyle(color: Colors.red.shade600, fontSize: 30),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.black,
          Colors.black,
          Colors.black,
          Colors.black,
          Colors.black,
          Colors.black,
        ])),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Form(
                key: state.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.length < 3) {
                            return 'nome no minimo 3 letras';
                          }

                          return null;
                        },
                        //autovalidateMode: AutovalidateMode.always,
                        controller: state.controllerName,
                        style: const TextStyle(color: Colors.red),
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.length < 3) {
                            return 'Minimo 3 letras';
                          }
                          return null;
                        },
                        //autovalidateMode: AutovalidateMode.always,
                        controller: state.controllerPassword,
                        style: const TextStyle(color: Colors.red),
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Center(
                          child: Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.red.shade900),
                                            onPressed: () async {
                                              await state.clearPreferences();
                                              final name =
                                                  state.controllerName.text;
                                              final password =
                                                  state.controllerPassword.text;
                                              final userLogin = await state
                                                  .getRegisterStore(name);
                                              // print(userLogin.id);
                                              await state.savedUser(
                                                  userLogin.id, userLogin.name);
                                              await state.loadUser();
                                              if (state.formKey.currentState!
                                                  .validate()) {
                                                if (userLogin != null &&
                                                    userLogin.password ==
                                                        password &&
                                                    context.mounted) {
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Home(),
                                                    ),
                                                  );
                                                }
                                              }
                                            },
                                            child: const Text(
                                              ' Login',
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 250,
                                        width: 700,
                                        child:
                                            Image.asset('assets/img/loogo.jpg'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
