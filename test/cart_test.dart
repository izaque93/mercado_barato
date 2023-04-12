import 'package:flutter_test/flutter_test.dart';
import 'package:mercado_barato/data/cart.dart';

void main() {
  group("Cart - getCheapestMarketListPrice", () {
    test('Cart should be incremented and need indicate m2 with 9.0', () {
      Item item = Item("item1")..marketsPrice = {"m1": 10.0, "m2": 9.0};
      Cart.add(item, 10);
      expect(Cart.getCheapestMarketListPrice(), {"m2": 90.0});
      Cart.dec(item, 10);
      expect(Cart.getCheapestMarketListPrice(), {});
    });
    test('Cart should be incremented and need indicate m2 with 18.0', () {
      Item item1 = Item("item1")
        ..marketsPrice = {"m1": 10.0, "m2": 9.0, "m3": 11.0};
      Item item2 = Item("item2")
        ..marketsPrice = {"m1": 10.0, "m2": 9.0, "m3": 11.0};
      Cart.add(item1, 10);
      Cart.add(item2, 10);
      expect(Cart.getCheapestMarketListPrice(), {"m2": 180.0},
          reason: "Cart should be with two items and 9*2*10 of value");
      Cart.dec(item1, 10);
      Cart.dec(item2, 10);
      expect(Cart.getCheapestMarketListPrice(), {});
    });
  });

  group("Cart - getTwoCheapestMarketsListPrice", () {
    test('Cart should be incremented and need indicate m2 with 180.0', () {
      Item item1 = Item("item1")
        ..marketsPrice = {"m1": 10.0, "m2": 9.0, "m3": 11.0};
      Item item2 = Item("item2")
        ..marketsPrice = {"m1": 10.0, "m2": 9.0, "m3": 11.0};
      Cart.add(item1, 10);
      Cart.add(item2, 10);
      expect(Cart.getTwoCheapestMarketsListPrice(), {"m2": 180.0},
          reason: "Expected the chepeast market is m2 and the second is m1");
      Cart.dec(item1, 10);
      Cart.dec(item2, 10);
      expect(Cart.getTwoCheapestMarketsListPrice(), {});
    });
    test(
        'Cart should be incremented and need indicate m2 with 90.0 and m1 with 85',
        () {
      Item item1 = Item("item1")
        ..marketsPrice = {"m1": 10.0, "m2": 9.0, "m3": 11.0};
      Item item2 = Item("item2")
        ..marketsPrice = {"m1": 8.5, "m2": 9.0, "m3": 11.0};
      Cart.add(item1, 10);
      Cart.add(item2, 10);
      expect(Cart.getTwoCheapestMarketsListPrice(), {"m2": 90.0, "m1": 85.0},
          reason: "Expected the chepeast market is m2 and the second is m1");
      Cart.dec(item1, 10);
      Cart.dec(item2, 10);
      expect(Cart.getTwoCheapestMarketsListPrice(), {});
    });
    test(
        'Cart should be incremented and need indicate m2 with 90.0 and m3 with 80',
        () {
      Item item1 = Item("item1")
        ..marketsPrice = {"m1": 10.0, "m2": 9.0, "m3": 11.0};
      Item item2 = Item("item2")
        ..marketsPrice = {"m1": 8.5, "m2": 9.0, "m3": 8.0};
      Cart.add(item1, 10);
      Cart.add(item2, 10);
      expect(Cart.getTwoCheapestMarketsListPrice(), {"m2": 90.0, "m3": 80.0},
          reason: "Expected the chepeast market is m2 and the second is m3");
      Cart.dec(item1, 10);
      Cart.dec(item2, 10);
      expect(Cart.getTwoCheapestMarketsListPrice(), {});
    });
    test('Cart should be incremented and need indicate m1 with 10.0', () {
      Item item1 = Item("item1")..marketsPrice = {"m1": 10.0};
      Cart.add(item1, 1);
      expect(Cart.getTwoCheapestMarketsListPrice(), {"m1": 10.0},
          reason: "Expected the chepeast market is m1 ");
      Cart.dec(item1, 1);
      expect(Cart.getTwoCheapestMarketsListPrice(), {});
    });
    test('Cart should be incremented and need indicate m2 with 9.0', () {
      Item item1 = Item("item1")
        ..marketsPrice = {"m1": 10.0, "m2": 9.0, "m3": 11.0};
      Cart.add(item1, 1);
      expect(Cart.getTwoCheapestMarketsListPrice(), {"m2": 9.0},
          reason: "Expected the chepeast market is m2 ");
      Cart.dec(item1, 1);
      expect(Cart.getTwoCheapestMarketsListPrice(), {});
    });
  });
  group("Cart - getThreeCheapestMarketsListPrice", () {
    test('Cart should be incremented and need indicate m2 with 180.0', () {
      Item item1 = Item("item1")
        ..marketsPrice = {"m1": 10.0, "m2": 9.0, "m3": 11.0};
      Item item2 = Item("item2")
        ..marketsPrice = {"m1": 10.0, "m2": 9.0, "m3": 11.0};
      Cart.add(item1, 10);
      Cart.add(item2, 10);
      expect(Cart.getThreeCheapestMarketsListPrice(), {"m2": 180.0},
          reason: "Expected the chepeast market is m2 and the second is m1");
      Cart.dec(item1, 10);
      Cart.dec(item2, 10);
      expect(Cart.getThreeCheapestMarketsListPrice(), {});
    });

    test(
        'Cart should be incremented and need indicate m2 with 90.0 and m1 with 80.0',
        () {
      Item item1 = Item("item1")
        ..marketsPrice = {"m1": 10.0, "m2": 9.0, "m3": 11.0};
      Item item2 = Item("item2")
        ..marketsPrice = {"m1": 8.0, "m2": 9.0, "m3": 11.0};
      Cart.add(item1, 10);
      Cart.add(item2, 10);
      expect(Cart.getThreeCheapestMarketsListPrice(), {"m1": 80.0, "m2": 90.0},
          reason: "");
      Cart.dec(item1, 10);
      Cart.dec(item2, 10);
      expect(Cart.getThreeCheapestMarketsListPrice(), {});
    });
  });
}
