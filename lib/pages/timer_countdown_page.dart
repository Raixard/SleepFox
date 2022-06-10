import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/timer_countdown_controller.dart';
import 'package:sleepfox/utils/widget_styles.dart';
import 'package:sleepfox/widgets/main_background.dart';
import 'package:sleepfox/widgets/small_widgets.dart';

class TimerCountdownPage extends StatelessWidget {
  const TimerCountdownPage({
    Key? key,
    required this.duration,
    required this.rhythm,
  }) : super(key: key);

  final int duration;
  final int rhythm;

  @override
  Widget build(BuildContext context) {
    final tcc = Get.put(
      TimerCountdownController(
        durationMinutes: duration,
        rhythm: rhythm * 100,
      ),
    );

    return Stack(
      children: [
        const MainBackground(),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          body: Padding(
            padding: defaultPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                    Obx(
                      () => AnimatedContainer(
                        width: tcc.inhaling.value
                            ? MediaQuery.of(context).size.width / 3
                            : 0,
                        height: tcc.inhaling.value
                            ? MediaQuery.of(context).size.width / 3
                            : 0,
                        curve: Curves.easeInOut,
                        duration: Duration(seconds: rhythm),
                        child: Image.asset("assets/main_page/moon.png"),
                      ),
                    ),
                  ],
                ),
                const SeparatorV(small: true),
                Obx(
                  () => Text(
                    tcc.prompts.value,
                    style: const TextStyle(
                      fontSize: 48,
                    ),
                  ),
                ),
                const SeparatorV(),
                Obx(
                  () => LinearProgressIndicator(
                    value: tcc.indicator.value,
                    minHeight: 28,
                  ),
                ),
                const SeparatorV(small: true),
                Obx(
                  () => Text(
                    tcc.timeLeft.value,
                    style: const TextStyle(
                      fontSize: 32,
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