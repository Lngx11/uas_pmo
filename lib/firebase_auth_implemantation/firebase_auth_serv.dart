// Mengimpor paket Firebase Authentication untuk autentikasi pengguna
import 'package:firebase_auth/firebase_auth.dart';

// Definisi kelas FirebaseAuthService untuk layanan autentikasi Firebase
class FirebaseAuthService {
  // Membuat instance FirebaseAuth
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Fungsi untuk mendaftar pengguna baru menggunakan email dan kata sandi
  Future<User?> SignUpWithEmailAndPassword(String username, String email, String Password) async {
    try {
      // Mencoba membuat pengguna baru dengan email dan kata sandi yang diberikan
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: Password);
      // Mengembalikan pengguna yang telah dibuat
      return credential.user;
    } catch (e) {
      // Menangani kesalahan yang terjadi selama proses pendaftaran
      print("some error occured");
    }
    // Mengembalikan null jika terjadi kesalahan
    return null;
  }

  // Fungsi untuk masuk pengguna menggunakan email dan kata sandi
  Future<User?> signInWithEmailAndPassword(String email, String Password) async {
    try {
      // Mencoba masuk dengan email dan kata sandi yang diberikan
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: Password);
      // Mengembalikan pengguna yang telah masuk
      return credential.user;
    } catch (e) {
      // Menangani kesalahan yang terjadi selama proses masuk
      print("some error occured");
    }
    // Mengembalikan null jika terjadi kesalahan
    return null;
  }
}
