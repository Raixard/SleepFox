import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/pages/main_page.dart';
import 'package:sleepfox/pages/registration_page.dart';
import 'package:sleepfox/utils/colors.dart';
import 'package:sleepfox/utils/widget_styles.dart';
import 'package:sleepfox/widgets/main_background.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                  "Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 32),
                TextField(
                  decoration: InputDecoration(
                    focusColor: cOrange,
                    fillColor: cDarkPurple.withOpacity(0.5),
                    filled: true,
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    focusColor: cOrange,
                    fillColor: cDarkPurple.withOpacity(0.5),
                    filled: true,
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock_rounded),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 32),
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
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  "Belum punya akun?",
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    Get.off(() => const RegistrationPage());
                  },
                  child: const Text(
                    "Daftar sekarang!",
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
