// Mengimpor paket Material Flutter untuk komponen UI
import 'package:flutter/material.dart';
// Mengimpor model keranjang dari aplikasi
import 'package:flutter_application_1/components/cartscreen.dart';
// Mengimpor paket Provider untuk manajemen state
import 'package:provider/provider.dart';

// Definisi kelas CheckoutScreen sebagai StatelessWidget
class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mendapatkan instance CartModel dari context menggunakan Provider
    var cartModel = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"), // Judul pada AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke layar sebelumnya
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartModel.items.length, // Jumlah item dalam keranjang
              itemBuilder: (context, index) {
                var item = cartModel.items[index];

                return ListTile(
                  leading: item['image'] != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            item['image'], // Menampilkan gambar item
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                      : null,
                  title: Text('${item['name']}'), // Menampilkan nama item
                  subtitle: Text('Rp. ${item['price']}'), // Menampilkan harga item
                  trailing: Text('Qty: ${item['quantity']}'), // Menampilkan jumlah item
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Total: Rp. ${cartModel.totalPrice}'), // Menampilkan total harga
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Implementasi logika checkout di sini
                    cartModel.clearCart(); // Mengosongkan keranjang
                    Navigator.pop(context); // Kembali ke layar keranjang
                  },
                  child: Text(
                    'Confirm and Pay', // Teks pada tombol konfirmasi
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 186, 41, 30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
