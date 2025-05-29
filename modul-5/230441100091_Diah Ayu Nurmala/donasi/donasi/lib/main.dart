import 'package:flutter/material.dart';
import 'screens/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Donasi',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomeDonasiScreen(),
    );
  }
}
