import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var name = "".obs;
  var email = "".obs;
  var userName = "".obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    var userId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
      .collection("users")
      .doc(userId)
      .get()
      .then((value) {
        name.value = value.get("name");
        email.value = value.get("email");
        userName.value = value.get("username");
    });
  }

  // fungsi untuk update info profil
  // dipanggil ketika pencet simpan di profil_edit_page
  updateInfo(String newName, newEmail) async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("users").doc(userId).update({
      "name": newName,
      "email": newEmail,
    });

    name.value = newName;
    email.value = newEmail;
  }
}