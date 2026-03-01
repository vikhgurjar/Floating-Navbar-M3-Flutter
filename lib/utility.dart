import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

ThemeData themeData() {
  return ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A6FD4),
          brightness: Brightness.light,
        ),
        // Unified elevated card style
        cardTheme: const CardThemeData(elevation: 0, margin: EdgeInsets.zero),
        // Typography — expressive scale
        textTheme: const TextTheme(
          displaySmall: TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: -1.5,
          ),
          headlineMedium: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
          headlineSmall: TextStyle(fontWeight: FontWeight.w700),
          titleLarge: TextStyle(fontWeight: FontWeight.w700),
          titleMedium: TextStyle(fontWeight: FontWeight.w600),
          labelLarge: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
  );
}

Color tabColor(BuildContext context, int currentIndex) {
  switch (currentIndex) {
    case 0: return const Color(0xFFBBDEFB); // Richer Blue
    case 1: return const Color(0xFFDCEDC8); // Richer Green
    case 2: return const Color(0xFFFFE0B2); // Richer Orange
    case 3: return const Color(0xFFE1BEE7); // Richer Purple
    case 4: return const Color(0xFFFFCDD2); // Richer Red
    default: return const Color(0xFFBBDEFB);
  }
}

// Helper function to launch the URL
Future<void> launchGitHub() async {
  final Uri url = Uri.parse('https://github.com/Damantha126');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}