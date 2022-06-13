import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/sign_in_up_form_controller.dart';
import 'package:sleepfox/methods/user_route_processing.dart';
import 'package:sleepfox/pages/login_page.dart';
import 'package:sleepfox/utils/colors.dart';
import 'package:sleepfox/utils/widget_styles.dart';
import 'package:sleepfox/widgets/main_background.dart';
import 'package:sleepfox/widgets/small_widgets.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({Key? key}) : super(key: key);

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
                  controller: signInUpController.emailController,
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
                  controller: signInUpController.userNameController,
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
                  controller: signInUpController.passwordConfirmController,
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
                      if (signInUpController.validateSignUp()) {
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email:
                                signInUpController.emailController.text.trim(),
                            password:
                                signInUpController.passwordController.text,
                          );

                          var userId = FirebaseAuth.instance.currentUser!.uid;
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(userId)
                              .set({
                            "email": signInUpController.emailController.text,
                            "username":
                                signInUpController.userNameController.text,
                            "name": signInUpController.userNameController.text,
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
                    Get.off(
                      () => LoginPage(),
                      transition: Transition.fadeIn,
                    );
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
