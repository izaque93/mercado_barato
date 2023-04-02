import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      drawer: Drawer(
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
            myListTile(context, Icons.assignment_add, "Nova Lista", () {}),
            // TODO: Update following icons
            myListTile(
                context, Icons.assignment_add, "Listas Anteriores", () {}),
            myListTile(context, Icons.assignment_add, "Carrinho", () {}),
            myListTile(
                context, Icons.assignment_add, "Histórico de Preços", () {}),
          ],
        ),
      ),
      body: Container(),
    );
  }

  ListTile myListTile(BuildContext context, IconData icon, String label,
      void Function()? onTap) {
    return ListTile(
      leading: Icon(icon),
      titleTextStyle: Theme.of(context).textTheme.labelLarge,
      textColor: Theme.of(context).primaryColor,
      iconColor: Theme.of(context).primaryColor,
      title: Text(label),
      onTap: onTap,
    );
  }
}
