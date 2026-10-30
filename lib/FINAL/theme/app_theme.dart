import 'package:flutter/material.dart';

class AppColors {
  static const Color ink = Color(0xFF1E1E1E);
  static const Color burgundy = Color(0xFF8B0000);
  static const Color burgundySoft = Color(0x1A8B0000);
  static const Color gold = Color(0xFFC9A24D);
  static const Color background = Color(0xFFF7F4EF);
  static const Color muted = Color(0xFF7A746C);
  static const Color divider = Color(0xFFEAE4DA);
  static const Color danger = Color(0xFFD32F2F);

  static const List<List<Color>> _gradients = [
    [Color(0xFF8B0000), Color(0xFFC0392B)],
    [Color(0xFF1E1E1E), Color(0xFF4A4A4A)],
    [Color(0xFF7B5E2A), Color(0xFFC9A24D)],
    [Color(0xFF3D2B56), Color(0xFF7E57C2)],
    [Color(0xFF0F4C5C), Color(0xFF2A9D8F)],
    [Color(0xFF6D2E46), Color(0xFFD1708B)],
  ];

  static List<Color> gradientFor(String id) =>
      _gradients[id.hashCode.abs() % _gradients.length];
}

class AppTheme {
  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.burgundy,
      brightness: Brightness.light,
    ).copyWith(primary: AppColors.burgundy);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.ink,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.ink,
        contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
        actionTextColor: AppColors.gold,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: AppColors.burgundySoft,
      ),
      dividerTheme: const DividerThemeData(color: AppColors.divider),
    );
  }
}
