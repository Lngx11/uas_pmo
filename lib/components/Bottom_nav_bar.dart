// Mengimpor paket Material Flutter untuk komponen UI
import 'package:flutter/material.dart';
// Mengimpor halaman profil, keranjang, dan beranda dari aplikasi
import 'package:flutter_application_1/camera/Profilepage.dart';
import 'package:flutter_application_1/homepage/cart.dart';
import 'package:flutter_application_1/homepage/home.dart';

// Fungsi utama yang menjalankan aplikasi
void main() {
  runApp(MyApp());
}

// Definisi kelas MyApp sebagai StatefulWidget
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

// State kelas MyApp
class _MyAppState extends State<MyApp> {
  // Indeks halaman yang dipilih pada BottomNavigationBar
  int _selectedIndex = 0;

  // Daftar halaman yang akan ditampilkan berdasarkan indeks
  static List<Widget> _widgetOptions = <Widget>[
    Home(onItemAddedToCart: (item) {  },), // Halaman beranda dengan fungsi callback kosong
    Cart(), // Halaman keranjang
    ProfilePage(), // Halaman profil
  ];

  // Fungsi untuk mengubah halaman yang dipilih pada BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema utama aplikasi
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bottom Navigation Example'), // Judul pada AppBar
        ),
        body: _widgetOptions.elementAt(_selectedIndex), // Menampilkan halaman yang dipilih
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home', // Item untuk halaman beranda
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart', // Item untuk halaman keranjang
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile', // Item untuk halaman profil
            ),
          ],
          currentIndex: _selectedIndex, // Indeks halaman yang dipilih saat ini
          selectedItemColor: Color.fromARGB(255, 186, 41, 30), // Warna item yang dipilih
          onTap: _onItemTapped, // Fungsi yang dipanggil saat item dipilih
        ),
      ),
    );
  }
}
