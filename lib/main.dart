import 'package:flutter/material.dart';
import 'package:resep_mpasi/page/page_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: false,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent
      ),
      home: const PageHome(),
    );
  }
}