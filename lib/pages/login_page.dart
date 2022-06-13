import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/sign_in_up_form_controller.dart';
import 'package:sleepfox/pages/registration_page.dart';
import 'package:sleepfox/utils/colors.dart';
import 'package:sleepfox/utils/widget_styles.dart';
import 'package:sleepfox/widgets/main_background.dart';
import 'package:sleepfox/widgets/small_widgets.dart';

import '../methods/user_route_processing.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final SignInUpController signInUpController = Get.put(SignInUpController());

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
                const SeparatorV(),
                TextField(
                  decoration: InputDecoration(
                    focusColor: cOrange,
                    fillColor: cDarkPurple.withOpacity(0.5),
                    filled: true,
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email),
                  ),
                  controller: signInUpController.emailController,
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
                  controller: signInUpController.passwordController,
                  obscureText: true,
                ),
                const SeparatorV(),
                SizedBox(
                  height: 64,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: cOrange,
                    ),
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: signInUpController.emailController.text.trim(),
                          password: signInUpController.passwordController.text,
                        );

                        Get.offAll(
                          () => const UserRouteProcessing(),
                          curve: Curves.easeInOut,
                          transition: Transition.fadeIn,
                          duration: const Duration(seconds: 2),
                        );
                      } on FirebaseAuthException catch (e) {
                        Get.dialog(
                            AlertDialog(content: Text(e.message!), actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text("Tutup"),
                          )
                        ]));
                      }
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
                const SeparatorV(),
                const Text(
                  "Belum punya akun?",
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    Get.off(
                      () => RegistrationPage(),
                      transition: Transition.fadeIn,
                    );
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
