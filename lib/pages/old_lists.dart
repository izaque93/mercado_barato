import 'package:flutter/material.dart';
import 'package:mercado_barato/data/cart.dart';
import 'package:mercado_barato/pages/market_details.dart';
import 'package:mercado_barato/pages/scaffold.dart';

class OldLists extends StatelessWidget {
  const OldLists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> itensRow = [];
    Storage.savedLists.forEach((list) {
      itensRow.add(GestureDetector(
        onTap: () {
          Cart.clear();
          list.setCart();

          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) =>
                  MarketDetails(Cart.getThreeCheapestMarketsListPrice())));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(list.timestamp.toString().substring(0, 19)),
            SizedBox(
                width: 50, child: Text(list.getTotalPrice().toStringAsFixed(2)))
          ],
        ),
      ));
      itensRow.add(const Divider());
    });

    return MyScaffold(
      child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 20.0)),
                    Text(
                      "Aqui estão suas últimas listas. Clique nelas para obter seus detalhes.",
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20.0)),
                    const Divider(),
                    const Padding(padding: EdgeInsets.only(top: 20.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Data",
                            style: Theme.of(context).textTheme.titleMedium),
                        SizedBox(
                            width: 50,
                            child: Text("Custo",
                                style:
                                    Theme.of(context).textTheme.titleMedium)),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 5.0)),
                    ...itensRow
                  ]))),
    );
  }
}
