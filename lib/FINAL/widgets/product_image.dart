import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../theme/app_theme.dart';

class ProductImage extends StatelessWidget {
  final Product product;
  final double iconSize;

  const ProductImage({super.key, required this.product, this.iconSize = 44});

  Widget _placeholder() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppColors.gradientFor(product.id),
        ),
      ),
      child: Center(
        child: Icon(Icons.local_florist_rounded,
            color: Colors.white70, size: iconSize),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (product.imageUrl.isEmpty) return _placeholder();
    return Image.network(
      product.imageUrl,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) =>
          progress == null ? child : _placeholder(),
      errorBuilder: (context, error, stackTrace) => _placeholder(),
    );
  }
}
