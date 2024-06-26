import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'CameraPage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? imageFile; // File untuk menyimpan gambar yang diambil dari kamera
  GoogleMapController? mapController; // Controller untuk Google Maps
  LatLng _initialPosition = LatLng(-6.200000, 106.816666); // Posisi awal untuk Google Maps

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'), // Judul AppBar
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('User Profile'), // Judul halaman profil
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                width: 250,
                height: 300,
                color: Colors.grey[200],
                child: (imageFile != null) ? Image.file(imageFile!) : SizedBox(), // Menampilkan gambar jika ada
              ),
              ElevatedButton(
                child: Text("Take Picture"), // Tombol untuk mengambil gambar
                onPressed: () async {
                  String? imagePath = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CameraPage()), // Navigasi ke halaman kamera
                  );
                  if (imagePath != null) {
                    setState(() {
                      imageFile = File(imagePath); // Set gambar yang diambil ke imageFile
                    });
                    await saveImageToPermanentStorage(imagePath); // Simpan gambar ke penyimpanan permanen
                  } else {
                    // Handle error from CameraPage
                    print('Error from CameraPage');
                  }
                },
              ),
              Container(
                height: 300, // Set tinggi kontainer untuk Google Maps
                child: GoogleMap(
                  onMapCreated: (controller) {
                    mapController = controller; // Inisialisasi controller Google Maps
                  },
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition, // Posisi kamera awal
                    zoom: 10, // Zoom awal
                  ),
                  onCameraMove: (position) {
                    _initialPosition = position.target; // Perbarui posisi awal berdasarkan pergerakan kamera
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveImageToPermanentStorage(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory(); // Dapatkan direktori dokumen aplikasi
    final fileName = basename(imagePath); // Ambil nama file dari path gambar
    final newPath = join(directory.path, fileName); // Gabungkan direktori dengan nama file

    final File newImage = await File(imagePath).copy(newPath); // Salin gambar ke lokasi permanen baru

    setState(() {
      imageFile = newImage; // Set imageFile ke gambar baru yang disalin
    });
  }
}
