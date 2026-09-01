import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const QrGeradorApp());
}

/// Widget raiz do aplicativo.
///
/// Configura o tema visual (Material 3) e define [HomeScreen]
/// como tela inicial do app.
class QrGeradorApp extends StatelessWidget {
  const QrGeradorApp({super.key});

  @override
  Widget build(BuildContext context) {
    final corPrimaria = const Color(0xFF3B5BFD);

    return MaterialApp(
      title: 'Gerador de QR Code',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: corPrimaria),
        scaffoldBackgroundColor: const Color(0xFFF5F6FB),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
