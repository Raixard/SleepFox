import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/pages/login_page.dart';
import 'package:sleepfox/pages/main_page.dart';
import 'package:sleepfox/utils/colors.dart';
import 'package:sleepfox/utils/widget_styles.dart';
import 'package:sleepfox/widgets/main_background.dart';
import 'package:sleepfox/widgets/small_widgets.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MainBackground(),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: Center(
            child: ListView(
              padding: defaultPadding,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                const Text(
                  "Registrasi",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SeparatorV(),
                TextField(
                  decoration: InputDecoration(
                    focusColor: cOrange,
                    fillColor: cDarkPurple.withOpacity(0.5),
                    filled: true,
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email_rounded),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SeparatorV(small: true),
                TextField(
                  decoration: InputDecoration(
                    focusColor: cOrange,
                    fillColor: cDarkPurple.withOpacity(0.5),
                    filled: true,
                    labelText: "Username",
                    prefixIcon: const Icon(Icons.person_rounded),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SeparatorV(small: true),
                TextField(
                  decoration: InputDecoration(
                    focusColor: cOrange,
                    fillColor: cDarkPurple.withOpacity(0.5),
                    filled: true,
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock_rounded),
                  ),
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                ),
                const SeparatorV(small: true),
                TextField(
                  decoration: InputDecoration(
                    focusColor: cOrange,
                    fillColor: cDarkPurple.withOpacity(0.5),
                    filled: true,
                    labelText: "Konfirmasi Password",
                    prefixIcon: const Icon(Icons.lock_rounded),
                  ),
                  obscureText: true,
                ),
                const SeparatorV(),
                SizedBox(
                  height: 64,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: cOrange,
                    ),
                    onPressed: () {
                      Get.off(() => MainPage());
                    },
                    child: const Text(
                      "Registrasi",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SeparatorV(),
                const Text(
                  "Sudah punya akun?",
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    Get.off(() => const LoginPage());
                  },
                  child: const Text(
                    "Login sekarang!",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
