import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/music_controller.dart';
import 'package:sleepfox/getx_controller/splash_screen_controller.dart';
import 'package:sleepfox/widgets/main_background.dart';
import 'package:sleepfox/widgets/small_widgets.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  
  final mc = Get.put(MusicController());

  @override
  Widget build(BuildContext context) {
    final ssc = Get.put(SplashScreenController());
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => AnimatedOpacity(
              opacity: ssc.playAnimationCheck.value ? 1 : 0,
              duration: const Duration(seconds: 1),
              child: const MainBackground(),
            ),
          ),
          Center(
            child: Obx(
              () => AnimatedOpacity(
                opacity: ssc.playAnimationCheck.value ? 1 : 0,
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOut,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      width: ssc.playAnimationCheck.value
                          ? MediaQuery.of(context).size.width / 2
                          : 50,
                      duration: const Duration(seconds: 2),
                      curve: Curves.easeInOutBack,
                      child: Image.asset(
                        "assets/icon/icon-white.png",
                      ),
                    ),
                    const SeparatorV(),
                    const Text(
                      "SleepFox",
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
