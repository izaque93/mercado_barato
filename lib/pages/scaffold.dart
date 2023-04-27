import 'package:flutter/material.dart';
import 'package:mercado_barato/data/cart.dart';
import 'package:mercado_barato/pages/new_list.dart';
import 'package:mercado_barato/pages/old_lists.dart';

class MyScaffold extends StatelessWidget {
  final Widget child;
  final Widget? bottomNavigationBar;
  const MyScaffold({Key? key, required this.child, this.bottomNavigationBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(context),
        drawer: drawer(context),
        body: child,
        bottomNavigationBar: bottomNavigationBar);
  }
}

AppBar appbar(BuildContext context) {
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
    actions: [
      Cart.count > 0
          ? IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const NewList()));
              },
              icon: const Icon(Icons.shopping_cart_outlined))
          : Container(),
    ],
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
          myListTile(context, Icons.note_add_outlined, "Nova Lista", () {
            Cart.clear();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const NewList()));
          }),
          myListTile(context, Icons.receipt_long_outlined, "Listas Anteriores",
              () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const OldLists()));
          }),
          myListTile(context, Icons.shopping_cart_outlined, "Carrinho", () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const NewList()));
          }),
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
