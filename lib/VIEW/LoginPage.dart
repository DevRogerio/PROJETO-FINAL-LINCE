import 'package:flutter/material.dart';

import 'Home.dart';

// ignore: public_member_api_docs
class LoginPage extends StatelessWidget {
  // ignore: public_member_api_docs
  TextEditingController loginController = TextEditingController();

  TextEditingController senhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  void dispose() {
    loginController.dispose();
    senhaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: BarraSuperior(),

      appBar: AppBar(
        title: Center(
          child: Text(
            'Anderson Carros',
            style: TextStyle(color: Colors.red.shade600, fontSize: 30),
          ),
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Form(
              //autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.length < 3) {
                          return "nome no minimo 3 letras";
                        }
                        /*else if (!value.contains('@')) {
                          return "esse nome parece estranho";
                        }*/
                        return null;
                      },
                      //autovalidateMode: AutovalidateMode.always,
                      controller: loginController,
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
                        if (value!.length < 5) {
                          return "A senha deve conter pelo menos 5 caracteres";
                        }
                        return null;
                      },
                      //autovalidateMode: AutovalidateMode.always,
                      controller: senhaController,
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
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.red.shade900),
                                        onPressed: () {
                                          if (_formKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Home()));
                                            /* print(
                                                  'login: ${loginController.text} senha:${senhaController.text}');*/
                                          }
                                        },
                                        child: const Text('Fazer Login'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.red.shade900),
                                        onPressed: () {},
                                        child: const Text('Cadastrar'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.red.shade900),
                                        onPressed: () {},
                                        child: const Text('Login ADM'),
                                      ),
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
    );
  }
}
