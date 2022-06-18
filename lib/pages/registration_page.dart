import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/sign_in_up_form_controller.dart';
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
                Column(
                  children: [
                    Image.asset(
                      "assets/icon/icon-white.png",
                      height: 150,
                    ),
                    const SeparatorV(small: true),
                    const Text(
                      "SleepFox",
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ),
                  ],
                ),
                const SeparatorV(),
                const Text(
                  "Registrasi",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SeparatorV(),
                TextInputField(
                  controller: signInUpController.emailController,
                  labelText: "Email",
                  icon: const Icon(Icons.email_rounded),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SeparatorV(small: true),
                TextInputField(
                  controller: signInUpController.userNameController,
                  labelText: "Username",
                  icon: const Icon(Icons.person_rounded),
                ),
                const SeparatorV(small: true),
                TextInputField(
                  controller: signInUpController.passwordController,
                  labelText: "Password",
                  icon: const Icon(Icons.lock_rounded),
                  obscureText: true,
                ),
                const SeparatorV(small: true),
                TextInputField(
                  controller: signInUpController.passwordConfirmController,
                  labelText: "Konfirmasi Password",
                  icon: const Icon(Icons.lock_rounded),
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                ),
                const SeparatorV(),
                SizedBox(
                  height: 64,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: cOrange,
                    ),
                    onPressed: () async {
                      signInUpController.signUpUser();
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
