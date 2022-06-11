import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/music_controller.dart';
import 'package:sleepfox/methods/audio_duration_listener.dart';

class AudioDurationBar extends StatelessWidget {
  const AudioDurationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mm = Get.find<MusicController>();
    final audioDurationListener = AudioDurationListener(mm.audioPlayer);
    return ValueListenableBuilder<DurationState>(
      valueListenable: audioDurationListener.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progress: value.progress,
          buffered: value.buffered,
          total: value.total,
          onSeek: (position) {
            mm.audioPlayer.seek(position);
          },
        );
      },
    );
  }
}
