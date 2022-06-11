import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sleepfox/getx_controller/music_controller.dart';

class AudioPreviousButton extends StatelessWidget {
  const AudioPreviousButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mm = Get.find<MusicController>();
    return StreamBuilder<SequenceState?>(
      stream: mm.audioPlayer.sequenceStateStream,
      builder: (context, builder) {
        return IconButton(
          icon: const Icon(Icons.skip_previous_rounded),
          onPressed:
              mm.audioPlayer.hasPrevious ? mm.audioPlayer.seekToPrevious : null,
        );
      },
    );
  }
}