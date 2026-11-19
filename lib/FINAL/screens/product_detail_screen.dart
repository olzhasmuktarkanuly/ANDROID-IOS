import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/cart_badge_button.dart';
import '../widgets/category_tag.dart';
import '../widgets/product_image.dart';
import '../widgets/share_sheet.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  final List<String>? images;

  const ProductDetailScreen({super.key, required this.product, this.images});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late final List<String> _images =
      (widget.images == null || widget.images!.isEmpty)
          ? [widget.product.imageUrl]
          : widget.images!;

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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  Widget _buildCarousel(Product product) {
    const radius = BorderRadius.only(
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
    );

    return Stack(
      children: [
        Container(
          height: 340,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white, borderRadius: radius),
          child: ClipRRect(
            borderRadius: radius,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _images.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (context, index) {
                final image = ProductImage(
                  product: product,
                  url: _images[index],
                  fit: BoxFit.contain,
                  iconSize: 90,
                );
                return Padding(
                  padding: EdgeInsets.all(24),
                  child: index == 0
                      ? Hero(tag: 'product_image_${product.id}', child: image)
                      : image,
                );
              },
            ),
          ),
        ),
        Positioned(
          top: 14,
          right: 16,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.ink.withOpacity(0.75),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${_currentPage + 1} / ${_images.length}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_images.length, (index) {
        final active = index == _currentPage;
        return AnimatedContainer(
          duration: Duration(milliseconds: 250),
          margin: EdgeInsets.symmetric(horizontal: 3),
          width: active ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: active ? Theme.of(context).colorScheme.primary : Color(0xFFD9D2C7),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }


  Widget _buildBottomBar(Product product, bool inCart) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 14, 20, 14),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price',
                      style: TextStyle(fontSize: 12, color: AppColors.muted)),
                  Text(
                    product.priceLabel,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 20),
              Expanded(
                child: inCart
                    ? OutlinedButton.icon(
                        onPressed: () =>
                            context.read<CartProvider>().toggle(product),
                        icon: Icon(Icons.check_rounded),
                        label: Text('In Cart · Remove'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.primary,
                          side: BorderSide(color: Theme.of(context).colorScheme.primary),
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      )
                    : FilledButton.icon(
                        onPressed: () =>
                            context.read<CartProvider>().toggle(product),
                        icon: Icon(Icons.add_shopping_cart_rounded),
                        label: Text('Add to Cart'),
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final inCart =
        context.select<CartProvider, bool>((cart) => cart.contains(product.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            tooltip: 'Share',
            icon: Icon(Icons.share_outlined),
            onPressed: () => showShareSheet(context, product),
          ),
          IconButton(
            tooltip: isFavorite ? 'Remove from favorites' : 'Save to favorites',
            icon: Icon(isFavorite ? Icons.bookmark : Icons.bookmark_border),
            color: isFavorite ? AppColors.burgundy : AppColors.ink,
            onPressed: toggleFavorite,
          ),
          CartBadgeButton(),
          SizedBox(width: 6),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCarousel(product),
            SizedBox(height: 14),
            _buildDots(),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(child: CategoryTag(text: product.categoryLabel)),
                      SizedBox(width: 10),
                      Icon(Icons.star_rounded,
                          color: Color(0xFFF5A623), size: 20),
                      SizedBox(width: 2),
                      Text(
                        product.ratingLabel,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '(${product.reviewCount} reviews)',
                        style: TextStyle(
                            fontSize: 13, color: AppColors.muted),
                      ),
                      if (product.isNew) ...[
                        SizedBox(width: 10),
                        NewBadge(),
                      ],
                    ],
                  ),
                  SizedBox(height: 14),
                  Text(
                    product.title,
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w700, height: 1.25),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 8),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 15.5,
                      height: 1.55,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(product, inCart),
    );
  }
}
