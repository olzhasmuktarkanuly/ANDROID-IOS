import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../theme/app_theme.dart';

class ProductImage extends StatelessWidget {
  final Product product;
  final String? url;
  final BoxFit fit;
  final double iconSize;

  const ProductImage({
    super.key,
    required this.product,
    this.url,
    this.fit = BoxFit.cover,
    this.iconSize = 44,
  });

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
    final source = url ?? product.imageUrl;
    if (source.isEmpty) return _placeholder();
    return Image.network(
      source,
      width: double.infinity,
      height: double.infinity,
      fit: fit,
      loadingBuilder: (context, child, progress) =>
          progress == null ? child : _placeholder(),
      errorBuilder: (context, error, stackTrace) => _placeholder(),
    );
  }
}
