import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/user_controller.dart';
import 'package:sleepfox/utils/colors.dart';
import 'package:sleepfox/widgets/main_background.dart';

class ProfileEditPage extends StatelessWidget {
  ProfileEditPage({Key? key}) : super(key: key);

  final UserController userCtrl = Get.put(UserController());

  // fungsi untuk membuat kotak input
  // menerima TextEditingController dan String untuk label sebagai parameter
  Widget inputBox({
    required TextEditingController controller_,
    required String text,
    dynamic type = TextInputType.text,
  }) {
    return TextField(
      keyboardType: type,
      controller: controller_,
      decoration: InputDecoration(
        labelText: text,
        fillColor: cLightPurple,
        filled: true,
      ),
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuerySize = MediaQuery.of(context).size;
    userCtrl.nameController.text = userCtrl.name.value;
    userCtrl.emailController.text = userCtrl.email.value;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profil"),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          TextButton(
              onPressed: () {
                userCtrl.updateInfo(
                  userCtrl.nameController.text,
                  userCtrl.emailController.text,
                );

                Get.back();

                Get.snackbar(
                  "Berhasil!",
                  "Profil berhasil disimpan",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: cOrange,
                  colorText: Colors.white,
                  margin: const EdgeInsets.all(12),
                );
              },
              child: Text("Simpan"))
        ],
      ),
      extendBodyBehindAppBar: true,
      body: MainBackground(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Column(
              children: [
                const SizedBox(height: 72),
                ClipOval(
                  child: CircleAvatar(
                      radius: mediaQuerySize.width / 6,
                      child: Image.asset(
                        "assets/gallery/1.jpg",
                        fit: BoxFit.cover,
                      )),
                ),
                const SizedBox(
                  height: 32,
                ),
                inputBox(controller_: userCtrl.nameController, text: "Nama"),
                const SizedBox(
                  height: 32,
                ),
                inputBox(controller_: userCtrl.emailController, text: "Email")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
