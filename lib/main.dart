import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/crypto_viewmodel.dart';
import 'views/home_screen.dart';
import 'repositories/crypto_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CryptoViewModel(CryptoRepository()),
      child: MaterialApp(
        title: 'Criptomoedas',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
} 