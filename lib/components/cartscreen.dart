// Mengimpor paket Material Flutter untuk komponen UI
import 'package:flutter/material.dart';

// Definisi kelas CartModel yang merupakan ChangeNotifier
class CartModel extends ChangeNotifier {
  // Daftar untuk menyimpan item di keranjang
  final List<Map<String, dynamic>> _items = [];

  // Getter untuk mengakses item di keranjang
  List<Map<String, dynamic>> get items => _items;

  // Fungsi untuk menambahkan item ke keranjang
  void addItem(Map<String, dynamic> item) {
    // Mencari indeks item berdasarkan nama
    int index = _items.indexWhere((element) => element['name'] == item['name']);
    if (index >= 0) {
      // Jika item sudah ada, tambahkan kuantitasnya
      _items[index]['quantity'] += 1;
    } else {
      // Jika item belum ada, tambahkan item baru dengan kuantitas 1
      item['quantity'] = 1;
      _items.add({
        'name': item['name'],
        'price': item['price'] is num ? item['price'] : num.tryParse(item['price'].toString()) ?? 0,
        'quantity': 1,
        'image': item['image'],
      });
    }
    // Memberitahu pendengar bahwa ada perubahan
    notifyListeners();
  }

  // Fungsi untuk menghapus item dari keranjang
  void removeItem(Map<String, dynamic> item) {
    // Mencari indeks item berdasarkan nama
    int index = _items.indexWhere((element) => element['name'] == item['name']);
    if (index >= 0) {
      // Jika item ditemukan dan kuantitas lebih dari 1, kurangi kuantitasnya
      if (_items[index]['quantity'] > 1) {
        _items[index]['quantity'] -= 1;
      } else {
        // Jika kuantitas item 1, hapus item dari keranjang
        _items.removeAt(index);
      }
      // Memberitahu pendengar bahwa ada perubahan
      notifyListeners();
    }
  }

  // Fungsi untuk memeriksa apakah item ada di keranjang
  bool isInCart(Map<String, dynamic> item) {
    return _items.any((element) => element['name'] == item['name']);
  }

  // Fungsi untuk mendapatkan kuantitas item di keranjang
  int getQuantity(Map<String, dynamic> item) {
    int index = _items.indexWhere((element) => element['name'] == item['name']);
    return index >= 0 ? _items[index]['quantity'] : 0;
  }

  // Getter untuk menghitung total harga item di keranjang
  double get totalPrice {
    double total = 0.0;
    _items.forEach((item) {
      total += (item['price'] as num).toDouble() * (item['quantity'] as int);
    });
    return total;
  }

  // Fungsi untuk mengosongkan keranjang
  void clearCart() {
    _items.clear();
    // Memberitahu pendengar bahwa ada perubahan
    notifyListeners();
  }
}
