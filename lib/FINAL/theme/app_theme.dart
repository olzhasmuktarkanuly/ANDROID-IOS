import 'package:flutter/material.dart';

class AppColors {
  static const Color ink = Color(0xFF1E1E1E);
  static const Color burgundy = Color(0xFF8B0000);
  static const Color gold = Color(0xFFC9A24D);
  static const Color danger = Color(0xFFD32F2F);

  static const Color muted = Color(0xFF8E8880);

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
  static ThemeData get light => _build(
        scheme: ColorScheme.fromSeed(
          seedColor: AppColors.burgundy,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.burgundy,
          surface: Colors.white,
        ),
        background: const Color(0xFFF7F4EF),
        divider: const Color(0xFFEAE4DA),
        snackBar: AppColors.ink,
      );

  static ThemeData get dark => _build(
        scheme: ColorScheme.fromSeed(
          seedColor: AppColors.burgundy,
          brightness: Brightness.dark,
        ).copyWith(
          primary: const Color(0xFFE57373),
          onPrimary: const Color(0xFF2B0000),
          surface: const Color(0xFF1E1E1E),
        ),
        background: const Color(0xFF121212),
        divider: const Color(0xFF332F2C),
        snackBar: const Color(0xFF3A3632),
      );

  static ThemeData _build({
    required ColorScheme scheme,
    required Color background,
    required Color divider,
    required Color snackBar,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      dividerColor: divider,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: scheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: snackBar,
        contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
        actionTextColor: AppColors.gold,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primary.withOpacity(0.18),
      ),
      dividerTheme: DividerThemeData(color: divider),
    );
  }
}
