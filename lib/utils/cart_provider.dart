import 'package:flutter/foundation.dart';

class CartItem {
  final String name;
  final String imagePath;
  final double price;
  int quantity;

  CartItem({
    required this.name,
    required this.imagePath,
    required this.price,
    this.quantity = 1,
  });
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  //Cantidad total de productos (suma de las cantidades)
  int get totalItems => _items.fold(0, (sum, i) => sum + i.quantity);

  //Total a pagar (precio x cantidad de cada producto)
  double get totalPrice =>
      _items.fold(0.0, (sum, i) => sum + i.price * i.quantity);

  // Se llama desde el botón "Add" de cada tile
  void addItem({
    required String name,
    required String imagePath,
    required double price,
  }) {
    final index = _items.indexWhere((i) => i.name == name);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(name: name, imagePath: imagePath, price: price));
    }
    notifyListeners();
  }

  void decreaseItem(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _items.remove(item);
    }
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  //Vacía el carrito (al presionar "Check out")
  void clear() {
    _items.clear();
    notifyListeners();
  }
}
