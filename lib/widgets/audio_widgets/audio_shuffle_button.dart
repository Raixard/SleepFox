import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/music_controller.dart';
import 'package:sleepfox/utils/colors.dart';

class AudioShuffleButton extends StatelessWidget {
  const AudioShuffleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mm = Get.find<MusicController>();
    return StreamBuilder<bool>(
      stream: mm.audioPlayer.shuffleModeEnabledStream,
      builder: (context, snapshot) {
        final isEnabled = snapshot.data ?? false;
        return IconButton(
          icon: const Icon(Icons.shuffle_rounded),
          color: isEnabled ? cOrange : Colors.white,
          onPressed: () async {
            final enable = !isEnabled;
            if (enable) {
              await mm.audioPlayer.shuffle();
            }
            await mm.audioPlayer.setShuffleModeEnabled(enable);
          },
        );
      },
    );
  }
}