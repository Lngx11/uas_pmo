 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/cartscreen.dart';
import 'package:provider/provider.dart';

// Definisi kelas Home sebagai StatefulWidget
class Home extends StatefulWidget {
  // Konstruktor Home dengan parameter callback onItemAddedToCart
  const Home({super.key, required this.onItemAddedToCart});

  // Callback untuk menambahkan item ke keranjang
  final Function(dynamic item) onItemAddedToCart;

  @override
  State<Home> createState() => _HomeState();
}

// Definisi state untuk Home
class _HomeState extends State<Home> {
  // Referensi ke instance Firebase Firestore
  var db = FirebaseFirestore.instance;

  // Fungsi untuk mengambil data dari koleksi 'Produk' di Firestore
  Future<List<QueryDocumentSnapshot>> getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Produk').get();
    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 20, 10),
        child: FutureBuilder<List<QueryDocumentSnapshot>>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            final data = snapshot.data;

            if (data == null || data.isEmpty) {
              return Text('No data found');
            }

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                var doc = data[index];
                var name = doc.get('name') as String;
                var price = doc.get('price').toString(); // Pastikan harga diubah menjadi String
                var image = doc.get('image') as String;
                var quantity = doc.get('quantity') ?? 0;

                var item = {
                  'name': name,
                  'price': price,
                  'image': image,
                  'quantity': quantity,
                };

                var cartModel = Provider.of<CartModel>(context);
                var isInCart = cartModel.isInCart(item);
                var cartQuantity = cartModel.getQuantity(item);

                return ListTile(
                  leading: Image.network(image, width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(name),
                  subtitle: Text('\Rp. $price'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isInCart)
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            cartModel.removeItem(item);
                          },
                        ),
                      if (isInCart) Text('$cartQuantity'),
                      IconButton(
                        icon: Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          cartModel.addItem(item);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Item added to cart!')),
                          );
                        },
                        color: isInCart ? Colors.grey : null,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
