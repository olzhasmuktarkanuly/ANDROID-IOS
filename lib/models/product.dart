import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String category;
  final String price;
  final String rating;
  final String description;
  final String imageUrl;

  final bool isNew;

  double get priceValue =>
      double.tryParse(price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;

  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.rating,
    required this.description,
    required this.imageUrl,
    this.isNew = false,
  });
}

final ValueNotifier<List<Product>> favoriteProductsNotifier = ValueNotifier([]);
