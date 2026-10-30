import 'package:flutter/material.dart';
import 'screens/root_screen.dart';
import 'theme/app_theme.dart';
import 'dart:ui' show PointerDeviceKind;

void main() {
  runApp(const LuxeParfumsApp());
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Luxe Parfums',
      theme: AppTheme.light,
      scrollBehavior: AppScrollBehavior(),
      home: const RootScreen(),
    );
  }
}
