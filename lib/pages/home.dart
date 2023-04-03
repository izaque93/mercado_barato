import 'package:flutter/material.dart';
import 'package:mercado_barato/pages/scaffold.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
        child: SafeArea(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "Mercados cadastrados na sua região",
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
            child: Image.asset(
          "assets/images/map.png",
          fit: BoxFit.fitHeight,
        ))
      ],
    )));
  }
}