import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../screens/cart_screen.dart';
import '../theme/app_theme.dart';

/// Иконка корзины с живым бейджем в AppBar. Открывает экран корзины.
class CartBadgeButton extends StatelessWidget {
  const CartBadgeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return IconButton(
          tooltip: 'Open cart',
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CartScreen()),
          ),
          icon: Badge(
            label: Text('${cart.itemCount}'),
            isLabelVisible: cart.itemCount > 0,
            backgroundColor: AppColors.burgundy,
            child: const Icon(Icons.shopping_bag_outlined, size: 26),
          ),
        );
      },
    );
  }
}
