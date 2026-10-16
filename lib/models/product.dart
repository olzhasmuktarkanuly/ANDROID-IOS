import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String category;
  final String price;
  final String rating;
  final String description;
  final String imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.rating,
    required this.description,
    required this.imageUrl,
  });
}

final ValueNotifier<List<Product>> favoriteProductsNotifier = ValueNotifier([]);