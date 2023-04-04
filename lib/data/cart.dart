class Item {
  final String name;

  bool isInCart = false;
  Map<String, double> marketsPrice = {};
  Item(this.name);

  void setPrice(double value, String market) =>
      marketsPrice.putIfAbsent(market, () => value);
}

// class Market {
//   final String name;
//   String location = "";
//   double distanceInKm = 0.0;
//   Map<Item, double> marketList = {};

//   Market(this.name);
// }
