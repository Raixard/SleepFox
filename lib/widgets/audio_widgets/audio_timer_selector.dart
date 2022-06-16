import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/music_controller.dart';
import 'package:sleepfox/utils/colors.dart';

class AudioTimerSelector extends StatelessWidget {
  const AudioTimerSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mm = Get.find<MusicController>();
    return BottomSheet(
      backgroundColor: cDarkPurple,
      onClosing: () {},
      builder: (context) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: mm.timerPreset.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return TextButton(
                onPressed: () {
                  mm.setTimer(0);
                  Get.back();
                },
                child: Text(
                  "Off",
                  style: TextStyle(
                      color: mm.timerIsOn.value ? Colors.white : cOrange),
                ),
              );
            } else {
              return TextButton(
                onPressed: () {
                  mm.setTimer(mm.timerPreset[index - 1]);
                  Get.back();
                },
                child: Text(
                  "${mm.timerPreset[index - 1]} menit",
                  style: TextStyle(
                    color: mm.timerIsOn.value &&
                            mm.timeSelected.value == mm.timerPreset[index - 1]
                        ? cOrange
                        : Colors.white,
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
