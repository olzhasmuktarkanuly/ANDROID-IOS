import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../LW11/services/storage_service.dart';
import '../../models/product.dart';
import '../../services/product_api_service.dart';
import '../theme/app_theme.dart';
import '../widgets/cart_badge_button.dart';
import '../widgets/empty_state.dart';
import '../widgets/explore_product_tile.dart';
import 'product_detail_screen.dart';

const bool kExploreOfflineCache = true;

enum _LoadState { loading, success, error }

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final ProductApiService _service = ProductApiService();
  late final StorageService _storage;
  bool _offline = false;

  _LoadState _state = _LoadState.loading;
  List<Product> _products = [];
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _storage = context.read<StorageService>();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() => _state = _LoadState.loading);
    try {
      final items = await _service.fetchProducts();
      if (!mounted) return;
      _storage.saveProducts(StorageService.keyExploreCache, items); // кэш
      setState(() {
        _products = items;
        _offline = false;
        _state = _LoadState.success;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      final cached = kExploreOfflineCache
          ? _storage.loadProducts(StorageService.keyExploreCache)
          : null;
      if (cached != null && cached.isNotEmpty) {
        setState(() {
          _products = cached;
          _offline = true;
          _state = _LoadState.success;
        });
      } else {
        setState(() {
          _errorMessage = e.message;
          _state = _LoadState.error;
        });
      }
    }
  }

  Future<void> _onRefresh() async {
    try {
      final items = await _service.fetchProducts();
      if (!mounted) return;
      _storage.saveProducts(StorageService.keyExploreCache, items);
      setState(() {
        _products = items;
        _offline = false;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  List<String> _galleryFor(Product product) {
    bool usable(Product p) => p.id != product.id && p.imageUrl.isNotEmpty;

    final sameCategory = _products
        .where((p) => usable(p) && p.category == product.category)
        .map((p) => p.imageUrl);
    final others = _products
        .where((p) => usable(p) && p.category != product.category)
        .map((p) => p.imageUrl);

    final gallery = <String>[product.imageUrl, ...sameCategory.take(2)];
    for (final url in others) {
      if (gallery.length >= 3) break;
      gallery.add(url);
    }
    return gallery;
  }

  void _openDetail(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailScreen(
          product: product,
          images: _galleryFor(product),
        ),
      ),
    );
  }


  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
    );
  }

  Widget _buildError() {
    return EmptyState(
      icon: Icons.wifi_off_rounded,
      title: 'Connection problem',
      message: _errorMessage,
      buttonLabel: 'Retry Connection',
      buttonIcon: Icons.refresh_rounded,
      onPressed: _loadProducts,
    );
  }

  Widget _buildFeed() {
    if (_products.isEmpty) {
      return EmptyState(
        icon: Icons.inventory_2_outlined,
        title: 'No products',
        message: 'The server returned an empty list.',
      );
    }
    final list = RefreshIndicator(
      color: Theme.of(context).colorScheme.primary,
      onRefresh: _onRefresh,
      child: ListView.separated(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: 24),
        itemCount: _products.length,
        separatorBuilder: (context, index) =>
            Divider(height: 1, thickness: 0.6, indent: 106),
        itemBuilder: (context, index) {
          final product = _products[index];
          return ExploreProductTile(
            product: product,
            onTap: () => _openDetail(product),
          );
        },
      ),
    );

    if (!_offline) return list;
    return Column(
      children: [
        _buildOfflineBanner(),
        Expanded(child: list),
      ],
    );
  }

  Widget _buildOfflineBanner() {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
      color: scheme.primary.withOpacity(0.14),
      child: Row(
        children: [
          Icon(Icons.wifi_off_rounded, size: 18, color: scheme.primary),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Offline mode · showing saved copy',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
          TextButton(onPressed: _loadProducts, child: Text('Retry')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget body;
    switch (_state) {
      case _LoadState.loading:
        body = _buildLoading();
        break;
      case _LoadState.error:
        body = _buildError();
        break;
      case _LoadState.success:
        body = _buildFeed();
        break;
    }

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
            Text('Explore'),
          ],
        ),
        actions: [CartBadgeButton(), SizedBox(width: 6)],
      ),
      body: SafeArea(child: body),
    );
  }
}
