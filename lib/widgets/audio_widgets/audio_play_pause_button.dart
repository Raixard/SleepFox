import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sleepfox/getx_controller/music_controller.dart';

class AudioPlayPauseButton extends StatelessWidget {
  const AudioPlayPauseButton({
    Key? key,
    this.isSmall = false,
  }) : super(key: key);

  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    final mm = Get.find<MusicController>();
    return StreamBuilder<PlayerState>(
      stream: mm.audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final processingState = snapshot.data!.processingState;
          if (processingState == ProcessingState.loading ||
              processingState == ProcessingState.buffering) {
            return SizedBox(
              width: !isSmall ? 64 : 32,
              height: !isSmall ? 64 : 32,
              child: const CircularProgressIndicator(),
            );
          } else if (!mm.audioPlayer.playing) {
            return IconButton(
              onPressed: mm.audioPlayer.play,
              iconSize: !isSmall ? 64 : 32,
              icon: const Icon(Icons.play_arrow_rounded),
            );
          } else if (processingState != ProcessingState.completed) {
            return IconButton(
              onPressed: mm.audioPlayer.pause,
              iconSize: !isSmall ? 64 : 32,
              icon: const Icon(Icons.pause_rounded),
            );
          } else {
            return IconButton(
              onPressed: () {
                mm.audioPlayer.seek(
                  Duration.zero,
                  index: mm.audioPlayer.effectiveIndices!.first,
                );
              },
              iconSize: !isSmall ? 64 : 32,
              icon: const Icon(Icons.replay_rounded),
            );
          }
        }
        return Container();
      },
    );
  }
}