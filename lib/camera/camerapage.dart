import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller; // Controller untuk mengontrol kamera
  bool isCameraInitialized = false; // Status inisialisasi kamera

  @override
  void initState() {
    super.initState();
    initializeCamera(); // Panggil fungsi untuk menginisialisasi kamera
  }

  Future<void> initializeCamera() async {
    try {
      // Ambil daftar kamera yang tersedia
      var cameras = await availableCameras();

      // Pilih kamera pertama dari daftar kamera yang tersedia
      controller = CameraController(cameras[0], ResolutionPreset.high);

      // Inisialisasi controller kamera
      await controller.initialize();

      // Jika kamera berhasil diinisialisasi, set state untuk menampilkan preview
      if (mounted) {
        setState(() {
          isCameraInitialized = true;
        });
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    // Dipanggil ketika widget dihapus, memastikan untuk menghapus controller kamera
    controller.dispose();
    super.dispose();
  }

  Future<void> onPressed(BuildContext context) async {
    try {
      // Dapatkan direktori sementara untuk menyimpan gambar
      final directory = await getTemporaryDirectory();

      // Generate path baru untuk gambar menggunakan timestamp
      final imagePath = join(directory.path, '${DateTime.now()}.jpg');

      // Ambil gambar dari kamera
      XFile imageFile = await controller.takePicture();

      // Simpan gambar ke path yang diinginkan
      await imageFile.saveTo(imagePath);

      // Kembali ke layar sebelumnya dan kembalikan path gambar
      if (mounted) {
        Navigator.pop(context, imagePath);
      }
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Warna latar belakang halaman
      body: isCameraInitialized
          ? Stack(
              children: [
                CameraPreview(controller), // Tampilkan preview dari kamera
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () => onPressed(
                          context), // Panggil fungsi onPressed saat tombol ditekan
                      child: Text('Take Picture'), // Teks pada tombol
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child:
                  CircularProgressIndicator(), // Tampilkan indikator loading saat kamera sedang diinisialisasi
            ),
    );
  }
}
