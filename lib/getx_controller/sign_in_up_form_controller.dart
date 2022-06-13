import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInUpController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final userNameController = TextEditingController();

  // validasi registrasi user, tidak boleh ada yang kosong
  bool validateSignUp() {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        passwordConfirmController.text.isEmpty ||
        userNameController.text.isEmpty) {
      Get.dialog(AlertDialog(
          content: const Text("Masih ada kolom yang kosong!"),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("Tutup"),
            )
          ]));
      return false;
    }

    // cek apakah password sama dengan konfirmasi password
    if (passwordController.text != passwordConfirmController.text) {
      Get.dialog(AlertDialog(
          content: const Text("Konfirmasi password salah"),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("Tutup"),
            )
          ]));
      return false;
    }
    return true;
  }
}
