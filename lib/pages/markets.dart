import 'package:flutter/material.dart';
import 'package:mercado_barato/data/cart.dart';
import 'package:mercado_barato/pages/market_details.dart';
import 'package:mercado_barato/pages/scaffold.dart';

class Markets extends StatelessWidget {
  const Markets({super.key});

  BottomAppBar bottomNavigationBar(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton.icon(
            icon: const Icon(Icons.cancel_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            },
            label: const Text("Cancelar"),
          ),
          const Padding(padding: EdgeInsets.only(left: 50)),
          FilledButton.icon(
              icon: const Icon(Icons.done_outlined),
              onPressed: Cart.count <= 0
                  ? null
                  : () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MarketDetails(
                              Cart.getThreeCheapestMarketsListPrice()
                                  )));
                    },
              label: const Text("Finalizar")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cheapestMarket = Cart.getCheapestMarketListPrice();
    final twoCheapestMarket = Cart.getTwoCheapestMarketsListPrice();
    final threeCheapestMarket = Cart.getThreeCheapestMarketsListPrice();
    final cheapestMarketValue = cheapestMarket.values.first;
    final twoCheapestMarketValue =
        twoCheapestMarket.values.reduce((value, element) => value + element);
    final threeCheapestMarketValue =
        threeCheapestMarket.values.reduce((value, element) => value + element);

    double minorMarketPrice = cheapestMarketValue < twoCheapestMarketValue
        ? cheapestMarketValue
        : twoCheapestMarketValue;

    minorMarketPrice = minorMarketPrice < threeCheapestMarketValue
        ? minorMarketPrice
        : threeCheapestMarketValue;

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
              "Escolha como você deseja fazer suas compras:",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            const Divider(),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        MarketDetails(cheapestMarket)));
              },
              child: oneMarket(minorMarketPrice, cheapestMarketValue, context,
                  cheapestMarket),
            ),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            const Divider(),
            // Two Markets -------------------
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        MarketDetails(twoCheapestMarket)));
              },
              child: twoMarkets(minorMarketPrice, twoCheapestMarketValue,
                  context, twoCheapestMarket),
            ),
            const Padding(padding: EdgeInsets.only(top: 20.0)),

            const Divider(),
            // three Markets -------------------
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        MarketDetails(threeCheapestMarket)));
              },
              child: threeMarkets(minorMarketPrice, threeCheapestMarketValue,
                  context, threeCheapestMarket),
            ),
          ],
        ),
      )),
    );
  }

  Container threeMarkets(
      double minorMarketPrice,
      double threeCheapestMarketValue,
      BuildContext context,
      Map<String, double> threeCheapestMarket) {
    return Container(
      color: minorMarketPrice == threeCheapestMarketValue
          ? Colors.green[50]
          : null,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Lista dividida em três mercados",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text("R\$ ${threeCheapestMarketValue.toStringAsFixed(2)}")
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 20.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                threeCheapestMarket.keys.elementAt(0),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                  "R\$ ${threeCheapestMarket.values.elementAt(0).toStringAsFixed(2)}")
            ],
          ),
          threeCheapestMarket.length >= 2
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      threeCheapestMarket.keys.elementAt(1),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                        "R\$ ${threeCheapestMarket.values.elementAt(1).toStringAsFixed(2)}")
                  ],
                )
              : Container(),
          threeCheapestMarket.length == 3
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      threeCheapestMarket.keys.elementAt(2),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                        "R\$ ${threeCheapestMarket.values.elementAt(2).toStringAsFixed(2)}")
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Container oneMarket(double minorMarketPrice, double cheapestMarketValue,
      BuildContext context, Map<String, double> cheapestMarket) {
    return Container(
      color: minorMarketPrice == cheapestMarketValue ? Colors.green[50] : null,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Mercado mais barato para toda a lista",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text("R\$ ${cheapestMarketValue.toStringAsFixed(2)}")
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
        ],
      ),
    );
  }

  Container twoMarkets(double minorMarketPrice, double twoCheapestMarketValue,
      BuildContext context, Map<String, double> twoCheapestMarket) {
    return Container(
      color:
          minorMarketPrice == twoCheapestMarketValue ? Colors.green[50] : null,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Lista dividida em dois mercados",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text("R\$ ${twoCheapestMarketValue.toStringAsFixed(2)}")
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 20.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                twoCheapestMarket.keys.elementAt(0),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                  "R\$ ${twoCheapestMarket.values.elementAt(0).toStringAsFixed(2)}")
            ],
          ),
          twoCheapestMarket.length == 2
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      twoCheapestMarket.keys.elementAt(1),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                        "R\$ ${twoCheapestMarket.values.elementAt(1).toStringAsFixed(2)}")
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
