import 'package:flutter/material.dart';

import 'pages/welcome_page.dart';

const Color darkPurple = Color(0xFF4A148C);

void main() {
  runApp(const ApipMarketApp());
}

class ApipMarketApp extends StatelessWidget {
  const ApipMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apip Market',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Tema ungu gelap + putih.
        colorScheme: ColorScheme.fromSeed(
          seedColor: darkPurple,
          primary: darkPurple,
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: darkPurple,
          foregroundColor: Colors.white,
        ),
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const WelcomePage(),
    );
  }
}
