import 'package:flutter/foundation.dart';

import '../models/book.dart';

class CartProvider extends ChangeNotifier {
  final Map<Book, int> _items = {};

  Map<Book, int> get items => Map.unmodifiable(_items);

  int get totalItems =>
      _items.values.fold(0, (total, quantity) => total + quantity);

  int get totalPrice => _items.entries.fold(
        0,
        (total, entry) => total + entry.key.price * entry.value,
      );

  void addItem(Book book) {
    _items.update(book, (quantity) => quantity + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  void removeItem(Book book) {
    final quantity = _items[book];
    if (quantity == null) return;

    if (quantity > 1) {
      _items[book] = quantity - 1;
    } else {
      _items.remove(book);
    }
    notifyListeners();
  }

  void clearCart() {
    if (_items.isEmpty) return;
    _items.clear();
    notifyListeners();
  }
}
