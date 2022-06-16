import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/user_controller.dart';
import 'package:sleepfox/utils/colors.dart';
import 'package:sleepfox/widgets/avatar_widget.dart';
import 'package:sleepfox/widgets/main_background.dart';

class ProfileEditPage extends StatelessWidget {
  ProfileEditPage({Key? key}) : super(key: key);

  final UserController userCtrl = Get.put(UserController());

  // fungsi untuk membuat kotak input
  // menerima TextEditingController dan String untuk label sebagai parameter
  // controller nya pasti sudah ada isinya jadi di kotak inputnya isinya adalah data user saat ini
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
              userCtrl.path.value = results.files.single.path!;
              userCtrl.fileName.value = results.files.single.name;
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
              userCtrl.imageEdited.value = true;
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
              userCtrl.imageEdited.value = false;
              userCtrl.deleteImage();
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
    userCtrl.nameController.text = userCtrl.name.value;
    userCtrl.emailController.text = userCtrl.email.value;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profil"),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          TextButton(
              onPressed: () async {
                userCtrl.updateInfo(
                  userCtrl.nameController.text,
                  userCtrl.emailController.text,
                  userCtrl.fileName.value,
                  userCtrl.path.value,
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
              child: const Text("Simpan"))
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
                AvatarWidget(
                    showEditIcon: true,
                    onClicked: () async => openBottomSheet()),
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
