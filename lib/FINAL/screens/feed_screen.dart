import 'package:flutter/material.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Discovery',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Featured Collections',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ProductCard(
                title: 'Macallan 18 Years Old',
                category: 'Single Malt Scotch',
                price: '\$399.00',
                rating: '4.9',
                icon: Icons.wine_bar,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductDetailScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              ProductCard(
                title: 'Yamazaki 12 Years Old',
                category: 'Japanese Whisky',
                price: '\$180.00',
                rating: '4.8',
                icon: Icons.local_bar,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}