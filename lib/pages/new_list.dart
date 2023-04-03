import 'package:flutter/material.dart';
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
  Map<String, double> filteredItensMap = {};

  @override
  void initState() {
    super.initState();
    filteredItensMap.addEntries(itensMap.entries);
    _searchController.addListener(() {
      filteredItensMap = {};
      if (_searchController.text.isEmpty) {
        setState(() {
          filteredItensMap.addEntries(itensMap.entries);
        });
      } else {
        setState(() {
          itensMap.forEach((key, value) {
            if (key.contains(_searchController.text)) {
              filteredItensMap.addEntries({key: value}.entries);
            }
          });
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
            SizedBox(
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
            ),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            Row(
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
            ),
            const Padding(padding: EdgeInsets.only(top: 8.0)),
            Expanded(
              child: ListView.separated(
                itemCount: filteredItensMap.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Expanded(
                          child: Text(filteredItensMap.keys.elementAt(index))),
                      const Padding(padding: EdgeInsets.only(left: 5.0)),
                      SizedBox(
                        width: _priceCollumnWidth,
                        child: Text(
                            "R\$${filteredItensMap[filteredItensMap.keys.elementAt(index)]!.toStringAsFixed(2)}"),
                      ),
                      SizedBox(
                        width: _cheboxCollumnWidth,
                        height: 30,
                        child: Checkbox(value: true, onChanged: (value) {}),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
