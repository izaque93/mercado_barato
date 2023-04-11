import 'package:flutter/material.dart';
import 'package:mercado_barato/data/cart.dart';
import 'package:mercado_barato/pages/scaffold.dart';

class Markets extends StatelessWidget {
  const Markets({super.key});

  @override
  Widget build(BuildContext context) {
    final cheapestMarket = Cart.getCheapestMarketListPrice();
    final twoCheapestMarket = Cart.getTwoCheapestMarketsListPrice();

    return MyScaffold(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              "Escolha como você deseja fazer suas compras:",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            const Divider(),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Mercado mais barato para toda a lista",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text("R\$ ${cheapestMarket.values.first.toStringAsFixed(2)}")
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cheapestMarket.keys.first,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text("R\$ ${cheapestMarket.values.first.toStringAsFixed(2)}")
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            const Divider(),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Lista dividida em dois mercados",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                    //TODO: Rename to sencond cheapest
                    "R\$ ${cheapestMarket.values.elementAt(0).toStringAsFixed(2)}")
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  //TODO: Rename to sencond cheapest
                  cheapestMarket.keys.elementAt(0),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(//TODO: Rename to sencond cheapest
                    "R\$ ${cheapestMarket.values.elementAt(0).toStringAsFixed(2)}")
              ],
            ),
          ],
        ),
      )),
    );
  }
}
