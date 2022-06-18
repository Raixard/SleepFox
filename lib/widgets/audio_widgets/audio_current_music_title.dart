import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:sleepfox/getx_controller/music_controller.dart';

class AudioCurrentMusicTitle extends StatelessWidget {
  const AudioCurrentMusicTitle({
    Key? key,
    this.isSmall = false,
  }) : super(key: key);

  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    final mm = Get.find<MusicController>();
    return StreamBuilder<SequenceState?>(
      stream: mm.audioPlayer.sequenceStateStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final currentItem = snapshot.data!.currentSource!.tag as MediaItem;
          return Text(
            currentItem.title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.fade,
            maxLines: 2,
            style: TextStyle(
              fontSize: !isSmall ? 32 : 24,
            ),
          );
        }
        return Container();
      },
    );
  }
}
