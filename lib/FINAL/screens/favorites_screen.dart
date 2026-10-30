import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../widgets/empty_state.dart';
import '../widgets/product_list_tile.dart';
import 'product_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Fragrances')),
      body: ValueListenableBuilder<List<Product>>(
        valueListenable: favoriteProductsNotifier,
        builder: (context, favorites, child) {
          if (favorites.isEmpty) {
            return const EmptyState(
              icon: Icons.bookmark_border_rounded,
              title: 'No favorites yet',
              message: 'Your favorite perfumes will appear here.',
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.only(bottom: 24),
            itemCount: favorites.length,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, thickness: 0.6, indent: 86),
            itemBuilder: (context, index) {
              final product = favorites[index];
              return ProductListTile(
                product: product,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(product: product),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
