import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> perfumes = [
      Product(
        id: '1',
        title: 'Tom Ford Oud Wood',
        category: 'Eau de Parfum',
        price: '\$395.00',
        rating: '4.9',
        imageUrl: 'https://images.unsplash.com/photo-1594035910387-fea47794261f?auto=format&fit=crop&w=500&q=80',
        description: 'A rare, exotic, and distinctive fragrance featuring classic woods and the iconic Tom Ford oud. Features rich notes of rose wood and cardamom.',
      ),
      Product(
        id: '2',
        title: 'Baccarat Rouge 540',
        category: 'Extrait de Parfum',
        price: '\$425.00',
        rating: '4.8',
        imageUrl: 'https://cdn.4stand.com/large2x/fd/b5/fdb5ab9323f3370bd4187b79d4ffaa8c367ea53e.webp',
        description: 'Luminous and sophisticated, Baccarat Rouge 540 lays on the skin like an amber floral and woody breeze.',
      ),
      Product(
        id: '3',
        title: 'Creed Aventus',
        category: 'Eau de Parfum',
        price: '\$365.00',
        rating: '4.7',
        imageUrl: 'https://basket-38.wbbasket.ru/vol8729/part872950/872950634/images/big/1.webp',
        description: 'Sensual, audacious and contemporary, this rich and iconic Eau de Parfum combines tantalizing fruity head notes with a woody base.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discovery', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: perfumes.length,
          itemBuilder: (context, index) {
            final product = perfumes[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ProductCard(
                title: product.title,
                category: product.category,
                price: product.price,
                rating: product.rating,
                imageUrl: product.imageUrl,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(product: product),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}