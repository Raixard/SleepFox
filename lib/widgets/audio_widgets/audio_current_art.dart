import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:sleepfox/getx_controller/music_controller.dart';
import 'package:sleepfox/utils/widget_styles.dart';

class AudioCurrentArt extends StatelessWidget {
  const AudioCurrentArt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mm = Get.find<MusicController>();
    return StreamBuilder<SequenceState?>(
      initialData: SequenceState(
        mm.audioPlayer.sequence!,
        mm.audioPlayer.currentIndex ?? 0,
        mm.audioPlayer.shuffleIndices!,
        mm.audioPlayer.shuffleModeEnabled,
        mm.audioPlayer.loopMode,
      ),
      stream: mm.audioPlayer.sequenceStateStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final currentItem = snapshot.data!.currentSource!.tag as MediaItem;
          return AspectRatio(
            aspectRatio: 1 / 1,
            child: ClipRRect(
              borderRadius: defaultBorderRadiusSmall,
              child: Hero(
                createRectTween: (begin, end) {
                  return MaterialRectArcTween(begin: begin, end: end);
                },
                tag: "audio-current-art",
                child: Image.asset(
                  currentItem.artUri.toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
