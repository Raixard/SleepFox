import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/user_controller.dart';
import 'package:sleepfox/utils/colors.dart';
import 'package:sleepfox/widgets/avatar_widget.dart';
import 'package:sleepfox/widgets/main_background.dart';
import 'package:sleepfox/widgets/small_widgets.dart';

class ProfileEditPage extends StatelessWidget {
  ProfileEditPage({Key? key}) : super(key: key);

  final UserController uc = Get.put(UserController());

  // fungsi untuk menampilkan bottomsheet, yang muncul di bagian bawah layar
  void openBottomSheet() {
    Get.bottomSheet(
      ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            title:
                const Text("Edit", style: TextStyle(color: Color(0xff333333))),
            leading: const Icon(
              Icons.photo_outlined,
              color: Color(0xff333333),
            ),
            onTap: () async {
              // ketika tombol edit dipencet maka disuruh untuk pilih gambar
              final results = await FilePicker.platform.pickFiles(
                allowMultiple: false,
                type: FileType.custom,
                allowedExtensions: ["png", "jpg"],
              );

              if (results == null) {
                Get.snackbar("Gagal!", "Tidak ada yang diunggah",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: cOrange,
                    colorText: Colors.white,
                    margin: const EdgeInsets.all(12));
                return;
              }

              // atur path dan fileName controller menjadi path dan filename gambar yang dipilih
              // nilai ini akan digunakan untuk mengupload file ke firebase
              uc.path.value = results.files.single.path!;
              uc.fileName.value = results.files.single.name;
              // imageEdited diubah ke true supaya AvatarWidget menampilkan gambar dengan path lokal saat ini bukan gambar dari firebase
              // ```
              // Obx(() => userCtrl.imageEdited.isTrue
              //    ? Image.file(
              //        userCtrl.file,
              //        fit: BoxFit.cover,
              //      )
              //    : RemotePicture(
              //        imagePath: userCtrl.image.value,
              //        mapKey: userCtrl.image.value
              //            .replaceFirst("avatar_image/", ""),
              //        fit: BoxFit.cover,
              //        placeholder: "assets/profile/hibernating_fox.png",
              //      ))
              // ```
              uc.imageEdited.value = true;
              Get.back();
            },
          ),
          ListTile(
            title: const Text(
              "Hapus Foto",
              style: TextStyle(color: Color(0xff333333)),
            ),
            leading: const Icon(
              Icons.delete_outline,
              color: Color(0xff333333),
            ),
            onTap: () {
              // imageEdited diset ke false berati AvatarWidget akan menampilkan gambar dari firebase
              // bukan dari nilai path.value
              uc.imageEdited.value = false;
              uc.deleteImage();
              Get.back();
            },
          )
        ],
      ),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    uc.nameController.text = uc.name.value;
    uc.emailController.text = uc.email.value;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profil"),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          TextButton(
              onPressed: () async {
                uc.updateInfo();
              },
              child: const Text("Simpan"))
        ],
      ),
      extendBodyBehindAppBar: true,
      body: MainBackground(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 72),
            AvatarWidget(
                showEditIcon: true, onClicked: () async => openBottomSheet()),
            const SeparatorV(),
            TextInputField(
              controller: uc.nameController,
              labelText: "Nama",
              icon: const Icon(Icons.person_rounded),
            ),
            const SeparatorV(),
            TextInputField(
              controller: uc.emailController,
              labelText: "Email",
              icon: const Icon(Icons.mail_rounded),
            ),
            const SeparatorV(),
            TextInputField(
              controller: uc.newPasswordController,
              labelText: "Password Baru",
              icon: const Icon(Icons.lock_reset_rounded),
              obscureText: true,
            ),
            const SeparatorV(),
            TextInputField(
              controller: uc.newPasswordConfirmController,
              labelText: "Konfirmasi Password Baru",
              icon: const Icon(Icons.lock_reset_rounded),
              obscureText: true,
            ),
            const SeparatorV(),
            const Text("Masukkan password saat ini bila ingin mengubah email atau password:"),
            const SeparatorV(small: true),
            TextInputField(
              controller: uc.passwordController,
              labelText: "Password Sekarang",
              icon: const Icon(Icons.lock_rounded),
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }
}
