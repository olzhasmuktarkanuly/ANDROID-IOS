import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;

  double get totalPrice =>
      _items.fold<double>(0, (sum, p) => sum + p.price);

  bool contains(String id) => _items.any((p) => p.id == id);

  void add(Product product) {
    if (contains(product.id)) return;
    _items.add(product);
    notifyListeners();
  }

  void remove(String id) {
    _items.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  void toggle(Product product) {
    if (contains(product.id)) {
      remove(product.id);
    } else {
      add(product);
    }
  }

  void clear() {
    if (_items.isEmpty) return;
    _items.clear();
    notifyListeners();
  }
}
