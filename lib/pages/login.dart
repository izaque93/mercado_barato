import 'package:flutter/material.dart';
import 'package:mercado_barato/pages/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: AspectRatio(
            aspectRatio: 1.0 / 2.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    'Mercado Barato',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                spacer(60),
                Text(
                  'Faça seu login',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                spacer(20),
                SizedBox(
                  height: 40,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      labelText: "Insira seu e-mail",
                    ),
                  ),
                ),
                spacer(20),
                SizedBox(
                  height: 40,
                  child: TextField(
                    onSubmitted: (text) {},
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      labelText: "Insira sua senha",
                    ),
                  ),
                ),
                spacer(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 120,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const Home()));
                        },
                        child: const Text("Login"),
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: FilledButton(
                        onPressed: () {},
                        child: const Text("Criar Conta"),
                      ),
                    )
                  ],
                ),
                spacer(40),
                Text(
                  "Esqueçeu sua senha ?",
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding spacer(double value) =>
      Padding(padding: EdgeInsets.only(bottom: value));
}
