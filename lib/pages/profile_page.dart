import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/pages/login_page.dart';
import 'package:sleepfox/utils/colors.dart';
import 'package:sleepfox/widgets/main_background.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainBackground(
        child: ListView(
          children: [
            Column(
              children: [
                const SizedBox(height: 72),
                ClipOval(
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 6,
                    child: Image.asset(
                      "assets/gallery/1.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  "Hengki Wisnuwibowo",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 32),
                ProfileButton(
                  icon: const Icon(Icons.edit_rounded),
                  text: "Edit Profil",
                  onPressed: () {},
                ),
                ProfileButton(
                  icon: const Icon(Icons.settings),
                  text: "Pengaturan",
                  onPressed: () {},
                ),
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
                  onPressed: () {
                    Get.off(() => LoginPage());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
