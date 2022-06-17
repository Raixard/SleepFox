import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sleepfox/utils/image_service.dart';

class UserController extends GetxController {
  var name = "".obs;
  var email = "".obs;
  var userName = "".obs;
  var image = "".obs;
  var imageEdited = false.obs;

  var path = "".obs;
  var fileName = "".obs;
  var currentUserId = "".obs;

  bool isDeleted = false;
  var newImage = "";

  File get file {
    return File(path.value);
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    saveUserInfo();
  }

  // ambil data user saat ini dan simpan ke variabel lokal
  void saveUserInfo() {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .get()
        .then((value) {
      name.value = value.get("name");
      userName.value = value.get("username");
      image.value = value.get("image");
    });
    currentUserId.value = userId;
  }

  // fungsi untuk update info profil
  // dipanggil ketika pencet simpan di ProfilEditPage
  updateInfo() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;

    // generate random string sebelum nama file untuk menghindari nama file yang sama
    fileName.value = base64Url.encode(
          List<int>.generate(32, (index) => Random().nextInt(256)),
        ) +
        fileName.value;

    if (path.value.isEmpty) {
      return;
    }

    // jika saat edit foto profil tidak menekan tombol hapus maka upload filenya ke firebase
    if (isDeleted == false) {
      await ImageService.uploadFile(
          path.value, "avatar_image/${fileName.value}");
      newImage = "avatar_image/${fileName.value}";
    }

    // update firestore dan auth dengan nilai yang diupdate
    FirebaseFirestore.instance.collection("users").doc(userId).update({
      "name": nameController.text,
      "image": newImage,
    });

    // update nilai yang diupdate ke variabel lokal
    name.value = nameController.text;
    image.value = newImage;
    isDeleted = false;
  }

  // fungsi ini dipanggil ketika pencet tombol hapus saat edit foto
  deleteImage() {
    isDeleted = true;
    // hapus file di firebase storage
    ImageService.deleteFile(image.value);
    image.value = "";
    newImage = "";
  }
}
