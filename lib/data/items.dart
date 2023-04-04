import 'cart.dart';

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
      itemsList.add(Item(key)..setPrice(value, "extra"));
    });
    return itemsList;
  }
}
