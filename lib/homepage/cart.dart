// Mengimpor paket Material Flutter untuk komponen UI
import 'package:flutter/material.dart';
// Mengimpor halaman Checkout khusus
import 'package:flutter_application_1/chekout/checkout.dart';
// Mengimpor komponen layar keranjang khusus
import 'package:flutter_application_1/components/cartscreen.dart';
// Mengimpor paket Provider untuk manajemen state
import 'package:provider/provider.dart';

// Definisi kelas Cart sebagai StatelessWidget
class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mendapatkan instance CartModel dari provider
    var cartModel = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke layar sebelumnya
          },
        ),
      ),
      body: cartModel.items.isEmpty
          ? Center(child: Text('No items in the cart')) // Menampilkan pesan jika keranjang kosong
          : ListView.builder(
              itemCount: cartModel.items.length, // Jumlah item dalam keranjang
              itemBuilder: (context, index) {
                var item = cartModel.items[index]; // Mendapatkan item berdasarkan indeks

                return ListTile(
                  leading: item['image'] != null // Menampilkan gambar jika ada
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            item['image'],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                      : null,
                  title: Text('${item['name']}'), // Menampilkan nama produk
                  subtitle: Text('Rp. ${item['price']}'), // Menampilkan harga produk
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          cartModel.removeItem(item); // Mengurangi item dari keranjang
                        },
                      ),
                      Text('${item['quantity']}'), // Menampilkan jumlah item dalam keranjang
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          cartModel.addItem(item); // Menambah item ke keranjang
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 236, 236, 236),
        child: Container(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                'Total: Rp ${cartModel.totalPrice}', // Menampilkan total harga
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 186, 41, 30)),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigasi ke layar checkout atau melakukan tindakan checkout
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckoutScreen()),
                  );
                },
                child: Text(
                  'Checkout',
                  style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 186, 41, 30)),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
