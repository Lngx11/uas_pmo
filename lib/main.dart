import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/cartscreen.dart';
import 'package:flutter_application_1/login/login.dart';
import 'package:provider/provider.dart';

// Fungsi main, titik masuk dari aplikasi
void main() async {
  // Memastikan binding Flutter telah diinisialisasi sebelum Firebase diinisialisasi
  WidgetsFlutterBinding.ensureInitialized();
  // Menginisialisasi Firebase
  await Firebase.initializeApp();
  // Menjalankan aplikasi dengan beberapa provider
  runApp(
    MultiProvider(
      providers: [
        // Mendaftarkan CartModel sebagai provider
        ChangeNotifierProvider(create: (context) => CartModel()),
      ],
      // Widget utama dari aplikasi
      child: MyApp(),
    ),
  );
}

// Widget Stateless untuk aplikasi utama
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Menetapkan judul dari aplikasi
      title: 'Flutter Demo',
      // Menetapkan tema dari aplikasi
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Menetapkan layar awal dari aplikasi ke layar Login
      home: Login(),
    );
  }
}
