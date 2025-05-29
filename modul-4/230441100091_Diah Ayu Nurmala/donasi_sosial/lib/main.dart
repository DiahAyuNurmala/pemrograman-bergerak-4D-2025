import 'package:flutter/material.dart';
import 'screen/donasi_screen.dart'; // Menyertakan HomeScreen dari screens

void main() {
  runApp(const DonasiApp());
}

class DonasiApp extends StatelessWidget {
  const DonasiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Donasi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:
          const HomeScreen(), // Mengarah ke HomeScreen untuk menampilkan daftar donasi
    );
  }
}
