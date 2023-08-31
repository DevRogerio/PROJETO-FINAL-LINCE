import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  var loginController = TextEditingController();
  var senhaController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  void dispose() {
    loginController.dispose();
    senhaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 182, 141, 7),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(235, 228, 14, 14),
        title: Center(
          child: (Text('Anderson Carros')),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
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
                        if (value!.length < 5) {
                          return "esse e-mail é curto demais";
                        } else if (!value.contains('@')) {
                          return "esse e-mail parece estranho";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.always,
                      controller: loginController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'E-mail',
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
                      // autovalidateMode: AutovalidateMode.always,
                      controller: senhaController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      obscureText: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: Column(
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(50.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState?.validate() ??
                                            false) {
                                          /* print(
                                              'login: ${loginController.text} senha:${senhaController.text}');*/
                                        }
                                      },
                                      child: const Text('Login'),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Cadastrar'),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: ElevatedButton(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
