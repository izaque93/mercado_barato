import 'package:flutter/material.dart';
import 'package:mercado_barato/data/cart.dart';
import 'package:mercado_barato/data/items.dart';
import 'package:mercado_barato/pages/scaffold.dart';

class NewList extends StatefulWidget {
  const NewList({Key? key}) : super(key: key);

  @override
  State<NewList> createState() => _NewListState();
}

class _NewListState extends State<NewList> {
  final _searchController = TextEditingController();
  final _priceCollumnWidth = 100.0;
  final _cheboxCollumnWidth = 30.0;
  List<Item> filteredItensList = [];

  @override
  void initState() {
    super.initState();
    Items items = Items();
    filteredItensList = items.loadFromDB();
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          filteredItensList = items.loadFromDB();
        });
      } else {
        filteredItensList = items.loadFromDB();
        setState(() {
          filteredItensList.removeWhere(
              (element) => !element.name.contains(_searchController.text));
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              "Selecione os itens que deseja adicionar a sua lista. Você também pode procurar na caixa de pesquisa abaixo.",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            const Divider(),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            searchbox(),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            tableTitles(context),
            const Padding(padding: EdgeInsets.only(top: 8.0)),
            Expanded(
              child: ListView.separated(
                itemCount: filteredItensList.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemBuilder: (BuildContext context, int index) {
                  return itemRow(filteredItensList.elementAt(index));
                },
              ),
            ),
          ],
        ),
      )),
    );
  }

  Row tableTitles(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
          "Nome",
          style: Theme.of(context).textTheme.bodyLarge,
        )),
        const Padding(padding: EdgeInsets.only(left: 5.0)),
        SizedBox(
            width: _priceCollumnWidth,
            child: Text(
              "Menor Preço",
              style: Theme.of(context).textTheme.bodyLarge,
            )),
        SizedBox(width: _cheboxCollumnWidth)
      ],
    );
  }

  SizedBox searchbox() {
    return SizedBox(
      height: 40,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        controller: _searchController,
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(),
          labelText: "Pesquise um item aqui",
        ),
      ),
    );
  }

  Row itemRow(Item item) {
    return Row(
      children: [
        Expanded(child: Text(item.name)),
        const Padding(padding: EdgeInsets.only(left: 5.0)),
        SizedBox(
          width: _priceCollumnWidth,
          child: Text(
              "R\$${item.marketsPrice.values.reduce((value, element) => value > element ? element : value).toStringAsFixed(2)}"),
        ),
        SizedBox(
          width: _cheboxCollumnWidth,
          height: 30,
          child: Checkbox(
              value: item.isInCart,
              onChanged: (value) {
                value ??= false;
                if (value == true) {
                  setState(() {
                    item.isInCart = true;
                  });
                } else {
                  setState(() {
                    item.isInCart = false;
                  });
                }
              }),
        )
      ],
    );
  }
}
