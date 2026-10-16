import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  bool get isFavorite => favoriteProductsNotifier.value.any((p) => p.id == widget.product.id);

  void toggleFavorite() {
    final currentFavorites = List<Product>.from(favoriteProductsNotifier.value);
    if (isFavorite) {
      currentFavorites.removeWhere((p) => p.id == widget.product.id);
    } else {
      currentFavorites.add(widget.product);
    }
    favoriteProductsNotifier.value = currentFavorites;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text(widget.product.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
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
                        Container(
                          width: double.infinity,
                          height: 350,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1E1E1E),
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                            child: Image.network(
                              widget.product.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 16, right: 16,
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), shape: BoxShape.circle),
                            child: IconButton(
                              icon: Icon(isFavorite ? Icons.bookmark : Icons.bookmark_border),
                              color: isFavorite ? const Color(0xFF8B0000) : Colors.black,
                              onPressed: toggleFavorite,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.product.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(widget.product.price, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Color(0xFF8B0000))),
                          const SizedBox(height: 16),
                          Text(widget.product.description, style: const TextStyle(fontSize: 16, color: Colors.black87, height: 1.5)),
                          const SizedBox(height: 30),
                          Center(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back, color: Colors.black),
                              label: const Text('Go Back to Feed', style: TextStyle(color: Colors.black)),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                side: const BorderSide(color: Colors.black),
                              ),
                            ),
                          )
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