import 'package:flutter/material.dart';
import '/screens/homecreen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import '/screens/form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Mahasiswa',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MahasiswaScreen(),
      routes: {'/add': (context) => const AddMahasiswaScreen()},
      debugShowCheckedModeBanner: false,
    );
  }
}
