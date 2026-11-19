import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../LW11/services/storage_service.dart';
import '../../models/product.dart';
import '../../models/product_seed.dart';
import '../theme/app_theme.dart';
import '../widgets/cart_badge_button.dart';
import '../widgets/delete_background.dart';
import '../widgets/empty_state.dart';
import '../widgets/product_grid_card.dart';
import '../widgets/product_list_tile.dart';
import 'product_detail_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late final StorageService _storage;
  late final List<Product> _products;
  bool _isGrid = false;

  @override
  void initState() {
    super.initState();
    _storage = context.read<StorageService>();
    _products = _storage.loadProducts(StorageService.keyFeedCatalog) ??
        buildSeedProducts();
  }

  void _persist() =>
      _storage.saveProducts(StorageService.keyFeedCatalog, _products);

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1500));
    if (!mounted) return;
    setState(() {
      _products.insert(0, ProductFactory.generate());
    });
    _persist();
  }

  void _removeProduct(Product product) {
    final originalIndex = _products.indexWhere((p) => p.id == product.id);
    if (originalIndex == -1) return;

    setState(() {
      _products.removeAt(originalIndex);
    });
    _persist();

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${product.title} removed'),
          duration: Duration(seconds: 4),
          action: SnackBarAction(
            label: 'UNDO',
            onPressed: () {
              if (!mounted) return;
              if (_products.any((p) => p.id == product.id)) return;
              final index = originalIndex > _products.length
                  ? _products.length
                  : originalIndex;
              setState(() {
                _products.insert(index, product);
              });
              _persist();
            },
          ),
        ),
      );
  }

  void _resetCatalog() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    setState(() {
      _products
        ..clear()
        ..addAll(buildSeedProducts());
    });
    _persist();
  }

  void _openDetail(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)),
    );
  }

  Widget _buildList() {
    return RefreshIndicator(
      key: ValueKey('list-view'),
      color: Theme.of(context).colorScheme.primary,
      onRefresh: _onRefresh,
      child: ListView.separated(
        primary: false,
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: 24),
        itemCount: _products.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          thickness: 0.6,
          indent: 86,
        ),
        itemBuilder: (context, index) {
          final product = _products[index];
          return Dismissible(
            key: ValueKey(product.id),
            direction: DismissDirection.endToStart, // справа налево
            background: DeleteBackground(),
            onDismissed: (_) => _removeProduct(product),
            child: ProductListTile(
              product: product,
              onTap: () => _openDetail(product),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGrid() {
    return RefreshIndicator(
      key: ValueKey('grid-view'),
      color: Theme.of(context).colorScheme.primary,
      onRefresh: _onRefresh,
      child: GridView.builder(
        primary: false,
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16, 4, 16, 24),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.72,
        ),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return Dismissible(
            key: ValueKey(product.id),
            direction: DismissDirection.endToStart,
            background: DeleteBackground(
              borderRadius: BorderRadius.circular(20),
              showLabel: false,
            ),
            onDismissed: (_) => _removeProduct(product),
            child: ProductGridCard(
              product: product,
              onTap: () => _openDetail(product),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 4, 20, 12),
      child: Row(
        children: [
          Text(
            '${_products.length} fragrances',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          Spacer(),
          Icon(Icons.swipe_left_rounded,
              size: 16, color: AppColors.muted),
          SizedBox(width: 4),
          Flexible(
            child: Text(
              'Swipe to delete · pull to refresh',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: AppColors.muted),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'LUXE PARFUMS',
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 3,
                fontWeight: FontWeight.w700,
                color: AppColors.gold,
              ),
            ),
            Text('Discovery'),
          ],
        ),
        actions: [
          CartBadgeButton(),
          IconButton(
            tooltip: _isGrid ? 'Show as list' : 'Show as grid',
            onPressed: () => setState(() => _isGrid = !_isGrid),
            icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Icon(
                _isGrid ? Icons.view_list_rounded : Icons.grid_view_rounded,
                key: ValueKey(_isGrid),
              ),
            ),
          ),
          SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: _products.isEmpty
            ? EmptyState(
                icon: Icons.inventory_2_outlined,
                title: 'Catalog is Empty',
                message:
                    'You have removed every fragrance.\nRestore the initial catalog to continue.',
                buttonLabel: 'Reset Catalog',
                onPressed: _resetCatalog,
              )
            : Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 250),
                      child: _isGrid ? _buildGrid() : _buildList(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
