import 'package:flutter/material.dart';
import 'package:mercado_barato/data/cart.dart';
import 'package:mercado_barato/pages/old_lists.dart';
import 'package:mercado_barato/pages/scaffold.dart';

class MarketDetails extends StatelessWidget {
  final Map<String, double> marketList;
  const MarketDetails(this.marketList, {Key? key}) : super(key: key);

  BottomAppBar bottomNavigationBar(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton.icon(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
            label: const Text("Voltar"),
          ),
          const Padding(padding: EdgeInsets.only(left: 50)),
          FilledButton.icon(
              icon: const Icon(Icons.done_outlined),
              onPressed: () {
                Cart.saveList();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const OldLists()));
              },
              label: const Text("Salvar")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemList = Cart.getListByMarkets(marketList.keys.toList());
    List<Widget> marketItems = [];
    marketList.forEach((market, value) {
      marketItems.add(Padding(
        padding: const EdgeInsets.only(top: 36.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              market,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "R\$ ${value.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      ));
      itemList[market]!.forEach((item, price) {
        marketItems.add(Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "- ${item.name}",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "R\$ ${price.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            ],
          ),
        ));
      });
    });
    return MyScaffold(
      bottomNavigationBar: bottomNavigationBar(context),
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              "Aqui está sua lista dividida entre ${marketList.length.toString()} mercados:",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            const Divider(),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            SizedBox(
              width: 500,
              height: 500,
              child: ListView(
                children: marketItems,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
