import 'package:cached_firestorage/remote_picture.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/music_controller.dart';
import 'package:sleepfox/getx_controller/user_controller.dart';
import 'package:sleepfox/pages/gallery_filtered_page.dart';
import 'package:sleepfox/pages/profile_edit_page.dart';
import 'package:sleepfox/utils/colors.dart';
import 'package:sleepfox/widgets/main_background.dart';
import 'package:sleepfox/widgets/small_widgets.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final UserController userCtrl = Get.put(UserController());
  final mm = Get.find<MusicController>();

  @override
  Widget build(BuildContext context) {
    double radius = MediaQuery.of(context).size.width / 6;
    return Scaffold(
      body: MainBackground(
        child: ListView(
          children: [
            Column(
              children: [
                const SizedBox(height: 72),
                RemotePicture(
                  // widget RemotePicture mengambil gambar dari firebase dan menyimpan cachenya
                  // parameter placeholder diisi gambar custom kalau userCtrl.image.value isinya kosong yaitu waktu gambar dihapus
                  imagePath: userCtrl.image.value,
                  mapKey: userCtrl.image.value.replaceFirst("avatar_image", ""),
                  useAvatarView: true,
                  avatarViewRadius: radius,
                  fit: BoxFit.cover,
                  placeholder: "assets/profile/hibernating_fox.png",
                ),
                const SeparatorV(),
                Obx(() => Text(
                      userCtrl.name.value,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                const SeparatorV(),
                Obx(() => Text(
                      userCtrl.userName.value,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    )),
                const SeparatorV(),
                ProfileButton(
                  icon: const Icon(Icons.edit_rounded),
                  text: "Edit Profil",
                  onPressed: () {
                    userCtrl.imageEdited.value = false;
                    Get.to(() => ProfileEditPage());
                  },
                ),
                const SeparatorV(small: true),
                ProfileButton(
                  icon: const Icon(Icons.filter_frames_rounded),
                  text: "Gambar Saya",
                  onPressed: () {
                    Get.to(
                      () => GalleryFilteredPage(isLikedPostsGallery: false),
                    );
                  },
                ),
                ProfileButton(
                  icon: const Icon(Icons.thumb_up_rounded),
                  text: "Gambar Disukai",
                  onPressed: () {
                    Get.to(
                      () => GalleryFilteredPage(isLikedPostsGallery: true),
                    );
                  },
                ),
                const SeparatorV(small: true),
                ProfileButton(
                  icon: const Icon(Icons.question_mark_rounded),
                  text: "Tentang",
                  onPressed: () {
                    showAboutDialog(
                      context: context,
                      applicationName: "SleepFox",
                      applicationVersion: "0.0.1",
                      applicationLegalese: "(CopyLeft) The SleepFox",
                      applicationIcon: Image.asset(
                        "assets/icon/icon-white.png",
                        height: 48,
                        width: 48,
                      ),
                    );
                  },
                ),
                ProfileButton(
                  icon: const Icon(Icons.exit_to_app_rounded),
                  text: "Keluar",
                  color: Colors.red,
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    mm.audioPlayer.stop();
                  },
                ),
                const SeparatorV(),
                Obx(
                  () => mm.bottomBarVisibility.value
                      ? const SizedBox(height: 72)
                      : Container(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// widget untuk membuat menu pilihan
// menerima color (optional), icon, text, dan fungsi ketika menu ditekan
class ProfileButton extends StatelessWidget {
  const ProfileButton({
    Key? key,
    this.color = Colors.white,
    required this.icon,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  final Color color;
  final Widget icon;
  final String text;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: OutlinedButton(
        onPressed: () {
          if (onPressed != null) onPressed!();
        },
        style: OutlinedButton.styleFrom(
          primary: color,
          backgroundColor: cDarkPurple.withOpacity(0.3),
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: 32,
            ),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
