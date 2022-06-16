import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

// utilitas yang berkaitan dengan mengakses gambar di firebase storage
class ImageService {
  // fungsi untuk mendapatkan link url dari file yang ada di firebase storage
  static Future<String> getImageURL(String image) async {
    String imageURL =
        await FirebaseStorage.instance.ref().child(image).getDownloadURL();
    return imageURL;
  }

  // fungsi untuk upload file ke firebase storage
  // filepath bernilai jalur ke file gambar di lokal
  // filename adalah nama filenya
  static Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);
    try {
      await FirebaseStorage.instance
          .ref(fileName)
          .putFile(file);
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // fungsi untuk menghapus file dari firebase storage
  static Future<void> deleteFile(String filePath) async {
    try {
      await FirebaseStorage.instance.ref().child(filePath).delete();
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
