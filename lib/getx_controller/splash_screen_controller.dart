import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/pages/login_page.dart';

class SplashScreenController extends GetxController {
  var playAnimationCheck = false.obs;

  @override
  void onInit() {
    super.onInit;
    playAnimation();
    splashScreenStart();
  }

  playAnimation() {
    return Timer(
      const Duration(seconds: 1),
      () => playAnimationCheck.value = true,
    );
  }

  splashScreenStart() {
    return Timer(
      const Duration(seconds: 3),
      () {
        Get.off(
          () => LoginPage(),
          curve: Curves.easeInOut,
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 1500),
        );
      },
    );
  }
}