import 'package:flutter/material.dart';

import 'screens/home_events_screen.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const NusaEventHubApp());
}

class NusaEventHubApp extends StatelessWidget {
  const NusaEventHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: brandTeal,
      primary: brandNavy,
      secondary: brandTeal,
      surface: Colors.white,
    );

    return MaterialApp(
      title: 'NusaEvent Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: canvasColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: canvasColor,
          foregroundColor: brandNavy,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFFE8ECF1)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF8F9FB),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE2E7EE)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE2E7EE)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: brandTeal, width: 1.5),
          ),
        ),
      ),
      home: const HomeEventsScreen(),
    );
  }
}
