import 'dart:ui' show PointerDeviceKind;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../LW11/services/storage_service.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart';
import 'screens/root_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final storage = StorageService(prefs);

  favoriteProductsNotifier.value =
      storage.loadProducts(StorageService.keyFavorites) ?? [];
  favoriteProductsNotifier.addListener(() {
    storage.saveProducts(
        StorageService.keyFavorites, favoriteProductsNotifier.value);
  });

  runApp(
    MultiProvider(
      providers: [
        Provider<StorageService>.value(value: storage),
        ChangeNotifierProvider(create: (_) => CartProvider(storage)),
        ChangeNotifierProvider(create: (_) => ThemeProvider(storage)),
      ],
      child: const LuxeParfumsApp(),
    ),
  );
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };
}

class LuxeParfumsApp extends StatelessWidget {
  const LuxeParfumsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDark;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Luxe Parfums',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      scrollBehavior: AppScrollBehavior(),
      home: const RootScreen(),
    );
  }
}
