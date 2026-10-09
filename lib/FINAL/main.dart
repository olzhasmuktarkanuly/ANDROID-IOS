import 'package:flutter/material.dart';
import 'screens/feed_screen.dart';

void main() {
  runApp(const PremiumSpiritsApp());
}

class PremiumSpiritsApp extends StatelessWidget {
  const PremiumSpiritsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Premium Spirits',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
      ),
      home: const FeedScreen(),
    );
  }
}