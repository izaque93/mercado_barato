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

AppBar appbar() {
  return AppBar(
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    ),
    title: const Text("Mercado Barato"),
  );
}

Drawer drawer(BuildContext context) => Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Text(
                'Mercado Barato',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          ),
          myListTile(context, Icons.note_add_outlined, "Nova Lista", () {}),
          myListTile(
              context, Icons.receipt_long_outlined, "Listas Anteriores", () {}),
          myListTile(context, Icons.shopping_cart_outlined, "Carrinho", () {}),
          myListTile(
              context, Icons.timeline_outlined, "Histórico de Preços", () {}),
        ],
      ),
    );
ListTile myListTile(
    BuildContext context, IconData icon, String label, void Function()? onTap) {
  return ListTile(
    leading: Icon(icon),
    titleTextStyle: Theme.of(context).textTheme.labelLarge,
    textColor: Theme.of(context).primaryColor,
    iconColor: Theme.of(context).primaryColor,
    title: Text(label),
    onTap: onTap,
  );
}
