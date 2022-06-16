import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/utils/user_route_processing.dart';

// Controller untuk mengatur autentikasi pengguna
class SignInUpController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final userNameController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // Validasi registrasi user
  bool validateSignUp() {
    // Input tidak boleh kosong
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

    // Cek apakah password sama dengan konfirmasi password
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

  // Registrasi pengguna
  void signUpUser() async {
    if (validateSignUp()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );

        var userId = FirebaseAuth.instance.currentUser!.uid;
        await FirebaseFirestore.instance.collection("users").doc(userId).set({
          "email": emailController.text,
          "username": userNameController.text,
          "name": userNameController.text,
        });

        Get.offAll(
          () => const UserRouteProcessing(),
          curve: Curves.easeInOut,
          transition: Transition.fadeIn,
          duration: const Duration(seconds: 2),
        );
      } on FirebaseAuthException catch (e) {
        Get.dialog(
          AlertDialog(
            content: Text(e.message!),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("Tutup"),
              ),
            ],
          ),
        );
      }
    }
  }

  // Masuk pengguna
  void signInUser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      Get.offAll(
        () => const UserRouteProcessing(),
        curve: Curves.easeInOut,
        transition: Transition.fadeIn,
        duration: const Duration(seconds: 2),
      );
    } on FirebaseAuthException catch (e) {
      Get.dialog(AlertDialog(content: Text(e.message!), actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text("Tutup"),
        )
      ]));
    }
  }
}
