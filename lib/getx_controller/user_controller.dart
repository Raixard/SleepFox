import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sleepfox/utils/colors.dart';
import 'package:sleepfox/utils/image_service.dart';
import 'package:sleepfox/utils/user_route_processing.dart';

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
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final newPasswordConfirmController = TextEditingController();

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
      email.value = value.get("email");
      userName.value = value.get("username");
      image.value = value.get("image");
    });
    currentUserId.value = userId;
  }

  // fungsi untuk update info profil
  // dipanggil ketika pencet simpan di ProfilEditPage
  updateInfo() async {
    if (emailController.text != email.value) {
      try {
        await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(
          EmailAuthProvider.credential(
            email: FirebaseAuth.instance.currentUser!.email!,
            password: passwordController.text,
          ),
        );
        await FirebaseAuth.instance.currentUser!
            .updateEmail(emailController.text);
      } on FirebaseAuthException {
        Get.defaultDialog(
          title: "Peringatan",
          middleText: "Password saat ini mungkin salah!",
        );
        return;
      }
    }

    if (newPasswordController.text != "") {
      if (newPasswordController.text == newPasswordConfirmController.text) {
        try {
          await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(
            EmailAuthProvider.credential(
              email: FirebaseAuth.instance.currentUser!.email!,
              password: passwordController.text,
            ),
          );
          await FirebaseAuth.instance.currentUser!
              .updatePassword(newPasswordController.text);
        } on FirebaseAuthException {
          Get.defaultDialog(
            title: "Peringatan",
            middleText:
                "Password saat ini mungkin salah atau password terlalu lemah!",
          );
          return;
        }
      } else {
        Get.defaultDialog(
          title: "Peringatan",
          middleText: "Konfirmasi password salah!",
        );
        return;
      }
    }

    passwordController.text = "";
    newPasswordController.text = "";
    newPasswordConfirmController.text = "";

    var userId = FirebaseAuth.instance.currentUser!.uid;

    // jika saat edit foto profil tidak menekan tombol hapus maka upload filenya ke firebase
    if (imageEdited.value) {
      await ImageService.uploadFile(path.value, "avatar_image/$userId");
      newImage = "avatar_image/$userId";
      imageEdited.value = false;
      await FirebaseFirestore.instance.collection("users").doc(userId).update({
        "image": newImage,
      });
      image.value = newImage;
    }

    // update firestore dan auth dengan nilai yang diupdate
    await FirebaseFirestore.instance.collection("users").doc(userId).update({
      "name": nameController.text,
      "email": emailController.text,
    });

    // update nilai yang diupdate ke variabel lokal
    name.value = nameController.text;
    email.value = emailController.text;
    isDeleted = false;

    Get.back();

    Get.snackbar(
      "Berhasil!",
      "Profil berhasil disimpan",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: cOrange,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
    );
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
