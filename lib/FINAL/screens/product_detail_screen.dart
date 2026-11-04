import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/cart_badge_button.dart';
import '../widgets/category_tag.dart';
import '../widgets/product_image.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool get isFavorite =>
      favoriteProductsNotifier.value.any((p) => p.id == widget.product.id);

  void toggleFavorite() {
    final current = List<Product>.from(favoriteProductsNotifier.value);
    if (isFavorite) {
      current.removeWhere((p) => p.id == widget.product.id);
    } else {
      current.add(widget.product);
    }
    favoriteProductsNotifier.value = current;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final inCart =
        context.select<CartProvider, bool>((cart) => cart.contains(product.id));
    const radius = BorderRadius.only(
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title, style: const TextStyle(fontSize: 16)),
        actions: const [CartBadgeButton(), SizedBox(width: 6)],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 340,
                          child: ClipRRect(
                            borderRadius: radius,
                            child: ProductImage(product: product, iconSize: 90),
                          ),
                        ),
                        Positioned(
                          top: 16,
                          right: 16,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.92),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              tooltip: isFavorite
                                  ? 'Remove from favorites'
                                  : 'Save to favorites',
                              icon: Icon(isFavorite
                                  ? Icons.bookmark
                                  : Icons.bookmark_border),
                              color: isFavorite
                                  ? AppColors.burgundy
                                  : AppColors.ink,
                              onPressed: toggleFavorite,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CategoryTag(text: product.category),
                              const SizedBox(width: 10),
                              const Icon(Icons.star_rounded,
                                  color: Color(0xFFF5A623), size: 20),
                              const SizedBox(width: 2),
                              Text(
                                product.rating,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 15),
                              ),
                              if (product.isNew) ...[
                                const SizedBox(width: 10),
                                const NewBadge(),
                              ],
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            product.title,
                            style: const TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.price,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: AppColors.burgundy,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            product.description,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              height: 1.55,
                            ),
                          ),
                          const SizedBox(height: 28),
                          SizedBox(
                            width: double.infinity,
                            child: inCart
                                ? OutlinedButton.icon(
                                    onPressed: () => context
                                        .read<CartProvider>()
                                        .toggle(product),
                                    icon: const Icon(Icons.check_rounded),
                                    label: const Text('In Cart · Tap to remove'),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: AppColors.burgundy,
                                      side: const BorderSide(
                                          color: AppColors.burgundy),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                  )
                                : FilledButton.icon(
                                    onPressed: () => context
                                        .read<CartProvider>()
                                        .toggle(product),
                                    icon: const Icon(
                                        Icons.add_shopping_cart_rounded),
                                    label: const Text('Add to Cart'),
                                    style: FilledButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 14),
                          Center(
                            child: OutlinedButton.icon(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back),
                              label: const Text('Go Back to Feed'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.ink,
                                side: const BorderSide(color: AppColors.ink),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
