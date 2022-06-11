import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sleepfox/getx_controller/music_controller.dart';
import 'package:sleepfox/utils/colors.dart';

class AudioLoopButton extends StatelessWidget {
  const AudioLoopButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mm = Get.find<MusicController>();
    const loopIcons = [
      Icon(Icons.repeat),
      Icon(Icons.repeat),
      Icon(Icons.repeat_one),
    ];
    const loopCycles = [
      LoopMode.off,
      LoopMode.all,
      LoopMode.one,
    ];
    const loopColors = [
      Colors.white,
      cOrange,
      cOrange,
    ];
    return StreamBuilder<LoopMode>(
      stream: mm.audioPlayer.loopModeStream,
      builder: (context, snapshot) {
        final loopMode = snapshot.data ?? LoopMode.off;
        final index = loopCycles.indexOf(loopMode);
        return IconButton(
          icon: loopIcons[index],
          color: loopColors[index],
          onPressed: () {
            mm.audioPlayer.setLoopMode(loopCycles[
                (loopCycles.indexOf(loopMode) + 1) % loopCycles.length]);
          },
        );
      },
    );
  }
}
