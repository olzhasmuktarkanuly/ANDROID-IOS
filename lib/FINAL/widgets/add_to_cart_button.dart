import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../theme/app_theme.dart';

class AddToCartButton extends StatelessWidget {
  final Product product;
  final double size;

  const AddToCartButton({super.key, required this.product, this.size = 36});

  @override
  Widget build(BuildContext context) {
    final inCart =
        context.select<CartProvider, bool>((cart) => cart.contains(product.id));

    return Tooltip(
      message: inCart ? 'Remove from cart' : 'Add to cart',
      child: Material(
        color: inCart ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primary.withOpacity(0.14),
        shape: CircleBorder(),
        child: InkWell(
          customBorder: CircleBorder(),
          onTap: () => context.read<CartProvider>().toggle(product),
          child: SizedBox(
            width: size,
            height: size,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: Icon(
                inCart ? Icons.check_rounded : Icons.add_shopping_cart_rounded,
                key: ValueKey(inCart),
                size: size * 0.55,
                color: inCart ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
