import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String imageUrl;
  final double rating;
  final int reviewCount;

  final bool isNew;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.rating,
    this.reviewCount = 0,
    this.isNew = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final ratingRaw = json['rating'];
    final ratingMap =
        ratingRaw is Map<String, dynamic> ? ratingRaw : <String, dynamic>{};

    return Product(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] as String?)?.trim() ?? 'Untitled product',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description:
          json['description'] as String? ?? 'No description available.',
      category: json['category'] as String? ?? 'general',
      imageUrl: json['image'] as String? ?? '',
      rating: (ratingMap['rate'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (ratingMap['count'] as num?)?.toInt() ?? 0,
      isNew: json['isNew'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': imageUrl,
        'rating': {'rate': rating, 'count': reviewCount},
        'isNew': isNew,
      };

  String get priceLabel => '\$${price.toStringAsFixed(2)}';

  String get ratingLabel => rating.toStringAsFixed(1);

  String get deepLink => 'narxoz://store/product/$id';

  String get categoryLabel {
    if (category != category.toLowerCase()) return category;
    return category
        .split(' ')
        .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }
}

final ValueNotifier<List<Product>> favoriteProductsNotifier = ValueNotifier([]);
