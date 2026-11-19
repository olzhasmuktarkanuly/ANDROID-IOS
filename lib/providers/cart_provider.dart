import 'package:flutter/foundation.dart';
import '../LW11/services/storage_service.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final StorageService _storage;
  final List<Product> _items;

  CartProvider(this._storage)
      : _items = _storage.loadProducts(StorageService.keyCart) ?? [];

  List<Product> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;

  double get totalPrice =>
      _items.fold<double>(0, (sum, p) => sum + p.price);

  bool contains(String id) => _items.any((p) => p.id == id);

  void _persist() => _storage.saveProducts(StorageService.keyCart, _items);

  void add(Product product) {
    if (contains(product.id)) return;
    _items.add(product);
    notifyListeners();
    _persist();
  }

  void remove(String id) {
    _items.removeWhere((p) => p.id == id);
    notifyListeners();
    _persist();
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
    _persist();
  }
}
