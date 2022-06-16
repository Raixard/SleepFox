import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/utils/user_route_processing.dart';

// Controller yang digunakan untuk mengatur splash screen
class SplashScreenController extends GetxController {
  // Menjalankan animasi bila bernilai true
  var playAnimationCheck = false.obs;

  // Dijalankan saat controller diinisialisasi
  @override
  void onInit() {
    super.onInit;
    playAnimation();
    splashScreenStart();
  }

  // Menjalankan animasi splash screen
  playAnimation() {
    return Timer(
      const Duration(seconds: 1),
      () => playAnimationCheck.value = true,
    );
  }

  // Menjalankan timer splash screen
  splashScreenStart() {
    return Timer(
      const Duration(seconds: 3),
      () {
        Get.off(
          () => const UserRouteProcessing(),
          curve: Curves.easeInOut,
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 1500),
        );
      },
    );
  }
}
