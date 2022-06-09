import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Class untuk menampung fungsi autentikasi pengguna
class AuthMethods {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // Registrasi pengguna
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
  }) async {
    return "";
  }

  // Fungsi keluar pengguna
  Future<void> signOutUser() async {
    await _auth.signOut();
  }
}