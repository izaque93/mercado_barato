import 'dart:math';

class Item {
  final String name;

  // bool isInCart = false;
  Map<String, double> marketsPrice = {};
  Item(this.name);

  void setPrice(double value, String market) =>
      marketsPrice.putIfAbsent(market, () => value);
}

class Cart {
  static final Map<Item, int> _cartList = {};

  static Map<String, double> getCheapestMarketListPrice() {
    Map<String, double> marketsTotalPrices = {};
    _cartList.forEach((item, qtd) {
      item.marketsPrice.forEach((market, price) {
        marketsTotalPrices[market] = marketsTotalPrices.containsKey(market)
            ? marketsTotalPrices[market]! + price * qtd
            : price * qtd;
      });
    });

    double minorPrice = 0;
    String cheapestMarket = "";
    marketsTotalPrices.forEach((market, totalPrice) {
      if (totalPrice < minorPrice || minorPrice == 0) {
        minorPrice = totalPrice;
        cheapestMarket = market;
      }
    });

    return cheapestMarket == ""
        ? {}
        : {cheapestMarket: marketsTotalPrices[cheapestMarket]!};
  }

  static Map<String, double> getTwoCheapestMarketsListPrice() {
    Map<String, double> cheapestMarket = getCheapestMarketListPrice();
    Map<String, Map<Item, int>> marketsListDifference = {};
    _cartList.forEach((item, qtd) {
      // set the a list for each market with items cheaper then cheapest market
      final minorMarketPrice = item.marketsPrice[cheapestMarket.keys.first]!;
      item.marketsPrice.forEach((market, price) {
        if (price < minorMarketPrice) {
          marketsListDifference[market] = {item: qtd};
        }
      });
    });

    if (marketsListDifference.isEmpty) return cheapestMarket;

    Map<String, double> totalDiference = {};
    Map<String, double> totalMarket = {};
    String minor = "";
    for (String market in marketsListDifference.keys) {
      marketsListDifference[market]!.forEach((item, qtd) {
        totalDiference[market] = qtd *
                (item.marketsPrice[cheapestMarket.keys.first]! -
                    item.marketsPrice[market]!) +
            (totalDiference[market] ?? 0);

        totalMarket[market] =
            qtd * item.marketsPrice[market]! + (totalMarket[market] ?? 0);
      });
      if (minor == "") {
        minor = market;
      } else {
        if (totalDiference[market] == null) continue;
        minor =
            totalDiference[market]! > totalDiference[minor]! ? market : minor;
      }
    }
    totalDiference[minor] ??= 0;
    cheapestMarket.addAll(<String, double>{minor: totalMarket[minor] ?? 0.0});
    cheapestMarket[cheapestMarket.keys.first] =
        cheapestMarket[cheapestMarket.keys.first]! -
            (totalDiference[minor]! + totalMarket[minor]!);

    return cheapestMarket;
  }

  static Map<String, double> getThreeCheapestMarketsListPrice() {
    Map<String, double> threeCheapestMarket = {};
    _cartList.forEach((item, qtd) {
      assert(item.marketsPrice.length <= 3);
      // get the minor value
      final minorValue = item.marketsPrice.values
          .reduce((value, element) => value < element ? value : element);
      // market for minor value
      final market = item.marketsPrice.keys
          .firstWhere((market) => item.marketsPrice[market] == minorValue);

      threeCheapestMarket[market] = threeCheapestMarket.containsKey(market)
          ? threeCheapestMarket[market]! + minorValue * qtd
          : minorValue * qtd;
    });

    return threeCheapestMarket;
  }

  static bool isInCart(Item item) => _cartList.keys.contains(item);

  static int get count => _cartList.length;

  static void add(Item item, int count) {
    if (Cart.isInCart(item)) {
      _cartList[item] = _cartList[item]! + count;
    } else {
      _cartList[item] = count;
    }
  }

  static void dec(Item item, int count) {
    if (Cart.isInCart(item)) {
      _cartList[item] = _cartList[item]! - count;
      if (_cartList[item]! <= 0) {
        _cartList.remove(item);
      }
    }
  }

  static void clear() {
    _cartList.clear();
  }
}

Map<String, double> itensMap = {
  "Carne Bovina Moída De Patinho Resfriada QUALITÁ Bandeja 500g": 24.57,
  "Leite Longa Vida Integral ITALAC 1 Litro": 5.29,
  "Feijão Carioca Premium 1kg - Caldo Bom": 14.99,
  "Arroz Agulhinha Tipo 1 Camil 5Kg": 24.35,
  "Farinha de Trigo Renata Integral Rico em Fibras 1kg": 13.19,
  "Batata Lavada Kg": 5.99,
  "Tomate Pra Valer Kg": 7.99,
  "Pão de Forma Tradicional Wickbold Premium Pacote 450g": 9.89,
  "Café Pilão Torrado E Moído Tradicional Almofada 500g": 19.99,
  "Banana Prata 600g": 6.47,
  "Açúcar Refinado UNIÃO Pacote 1kg": 4.99,
  "Óleo de Soja LIZA Pet 900ml": 8.69,
  "Manteiga Francesa com Sal PRÉSIDENT Tablete 200g": 11.99,
};

class Items {
  List<Item> loadFromDB() {
    List<Item> itemsList = [];
    itensMap.forEach((key, value) {
      itemsList.add(Item(key)
        ..setPrice(value, "Extra")
        // Generate a random value to next markets
        ..setPrice(
            value +
                (Random().nextBool() == true
                    ? Random().nextDouble()
                    : Random().nextDouble() * -1),
            "Dia")
        ..setPrice(
            value +
                (Random().nextBool() == true
                    ? Random().nextDouble()
                    : Random().nextDouble() * -1),
            "Assaí"));
    });
    return itemsList;
  }
}
