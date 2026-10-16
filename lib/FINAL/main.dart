import 'package:flutter/material.dart';
import 'screens/feed_screen.dart';
import 'screens/root_screen.dart';

void main() {
  runApp(const LuxeParfumsApp());
}

class LuxeParfumsApp extends StatelessWidget {
  const LuxeParfumsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Luxe Parfums',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
      ),
      home: const RootScreen(),
    );
  }
}
