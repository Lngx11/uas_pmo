import 'package:flutter/material.dart';
import 'package:flutter_application_1/camera/Profilepage.dart';
import 'package:flutter_application_1/homepage/cart.dart';
import 'package:flutter_application_1/homepage/home.dart';

// Definisi kelas HomePage sebagai StatefulWidget
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

// Definisi state untuk HomePage
class _HomePageState extends State<HomePage> {
  // Menyimpan indeks halaman yang dipilih
  int _selectedIndex = 0;
  // List untuk menyimpan item-item dalam keranjang
  List<Map<String, dynamic>> cartItems = []; 

  // Fungsi untuk navigasi BottomNavigationBar
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // List untuk menyimpan halaman-halaman yang akan ditampilkan
  late List<Widget> _pages;

  // Metode yang dijalankan saat inisialisasi state
  @override
  void initState() {
    super.initState();
    _pages = [
      // Halaman Home dengan callback untuk menambah item ke keranjang
      Home(
        onItemAddedToCart: (item) {
          setState(() {
            int index = cartItems.indexWhere((element) => element['id'] == item['id']);
            if (index != -1) {
              cartItems[index]['quantity'] += 1; // Tambah jumlah item jika sudah ada
            } else {
              cartItems.add({...item, 'quantity': 1}); // Tambahkan item baru ke keranjang
            }
          });
        },
      ),
      Cart(), // Halaman Cart
      ProfilePage(), // Halaman ProfilePage
    ];
  }

  // Metode build untuk membangun UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, // Indeks item yang dipilih
        selectedItemColor: const Color.fromARGB(255, 186, 41, 30), // Warna item yang dipilih
        onTap: navigateBottomBar, // Callback saat item dipilih
      ),
      body: _pages[_selectedIndex], // Menampilkan halaman yang dipilih
    );
  }
}
