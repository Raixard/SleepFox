import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/timer_form_controller.dart';
import 'package:sleepfox/utils/colors.dart';
import 'package:sleepfox/utils/widget_styles.dart';
import 'package:sleepfox/widgets/main_background.dart';
import 'package:sleepfox/widgets/small_widgets.dart';
import 'package:sleepfox/pages/timer_countdown_page.dart';

class TimerPage extends StatelessWidget {
  TimerPage({Key? key}) : super(key: key);

  final tfc = Get.put(TimerFormController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MainBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: ListView(
              padding: defaultPadding,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                const Text(
                  "Timer Pernapasan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SeparatorV(),
                Container(
                  padding: defaultPaddingSmall,
                  decoration: BoxDecoration(
                    borderRadius: defaultBorderRadiusSmall,
                    color: cDarkPurple.withOpacity(0.5),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text("Durasi"),
                          ),
                          Obx(
                            () => Expanded(
                              flex: 2,
                              child: DropdownButton<int>(
                                dropdownColor: cDarkPurple,
                                onChanged: (value) {
                                  tfc.setDuration(value!);
                                },
                                value: tfc.duration.value,
                                items: tfc.durationPresets.map((e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Text("$e menit"),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: Text("Ritme"),
                          ),
                          Obx(
                            () => Expanded(
                              flex: 2,
                              child: DropdownButton<int>(
                                dropdownColor: cDarkPurple,
                                onChanged: (value) {
                                  tfc.setRhythm(value!);
                                },
                                value: tfc.rhythm.value,
                                items: tfc.rhythmPresets.map((e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Text("$e detik"),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SeparatorV(),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: cOrange,
                    ),
                    onPressed: () {
                      Get.to(() =>
                        TimerCountdownPage(
                          duration: tfc.duration.value,
                          rhythm: tfc.rhythm.value,
                        ),
                      );
                    },
                    child: const Text(
                      "Mulai",
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
