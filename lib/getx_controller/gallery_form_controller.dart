import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/gallery_controller.dart';
import 'package:sleepfox/utils/image_service.dart';

class GalleryFormController extends GetxController {
  // Path file di device user
  var filePath = "".obs;
  // Nama file untuk disimpan di cloud
  var fileName = "".obs;
  // Judul/deskripsi gambar
  TextEditingController titleController = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var results;

  // Saat controller ini sudah siap,
  // maka secara otomatis akan meminta user
  // memilih gambar untuk di-post
  @override
  void onReady() {
    super.onReady();
    pickImage();
  }

  // Konversi path file menjadi file
  File get file {
    return File(filePath.value);
  }

  // Mengambil gambar dari device user
  void pickImage() async {
    // Mengambil gambar
    results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ["png", "jpg"],
    );

    // Bila tidak ada yang diambil, akan batal dan
    // kembali ke halaman sebelumnya
    if (results == null) {
      Get.back();
      Get.snackbar(
        "Gagal!",
        "Tidak ada yang diunggah",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
      );
      return;
    }

    // Memasukkan data gambar yang dipilih oleh user
    filePath.value = results.files.single.path!;
    fileName.value = results.files.single.name;
  }

  // Meng-upload gambar yang dipilih user
  void postImage() async {
    // Mengambil id user saat ini
    var userId = FirebaseAuth.instance.currentUser!.uid;

    // Memberi nama random pada awalan nama file
    // agar tidak ada file dengan nama yang sama
    fileName.value = base64Url.encode(
          List<int>.generate(
            32,
            (i) => Random().nextInt(256),
          ),
        ) +
        fileName.value;
    // File akan disimpan di folder gallery_posts/id user/
    // di Firebase Storage
    fileName.value = "gallery_posts/$userId/${fileName.value}";

    // Mencegah proses upload bila filePath kosong
    if (filePath.value.isEmpty) {
      return;
    }

    // Mengunggah gambar ke Firebase Storage
    await ImageService.uploadFile(filePath.value, fileName.value);

    // Menambahkan data post ke Firestore
    await FirebaseFirestore.instance.collection("gallery_posts").add({
      "title": titleController.text,
      "image": fileName.value,
      "likes": [],
      "poster": userId,
      "timePublished": Timestamp.now(),
    });

    // Kembali ke halaman sebelumnya dan menampilkan snackbar
    Get.back();
    Get.snackbar(
      "Berhasil!",
      "Berhasil ditambahkan!",
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
    );

    // Me-refresh database lokal
    final gc = Get.find<GalleryController>();
    gc.getData();
  }
}
