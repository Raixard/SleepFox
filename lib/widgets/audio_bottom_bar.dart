import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/music_controller.dart';
import 'package:sleepfox/pages/music_player_page.dart';
import 'package:sleepfox/utils/colors.dart';
import 'package:sleepfox/utils/widget_styles.dart';
import 'package:sleepfox/widgets/audio_widgets/audio_current_art.dart';
import 'package:sleepfox/widgets/audio_widgets/audio_current_music_title.dart';
import 'package:sleepfox/widgets/audio_widgets/audio_next_button.dart';
import 'package:sleepfox/widgets/audio_widgets/audio_play_pause_button.dart';
import 'package:sleepfox/widgets/audio_widgets/audio_previous_button.dart';

class AudioBottomBar extends StatelessWidget {
  const AudioBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mm = Get.find<MusicController>();
    return Obx(
      () => Visibility(
        visible: mm.bottomBarVisibility.value,
        child: Container(
          alignment: Alignment.bottomCenter,
          padding: defaultPaddingSmall,
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              color: cDarkPurple.withOpacity(0.5),
              borderRadius: defaultBorderRadius,
            ),
            child: GestureDetector(
              onTap: () {
                Get.to(() => const MusicPlayerPage());
              },
              onPanUpdate: (details) {
                if (details.delta.dy > 0) {
                  mm.audioPlayer.stop();
                  mm.bottomBarVisibility.value = false;
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: defaultPaddingSmall,
                    child: AudioCurrentArt(),
                  ),
                  const AudioCurrentMusicTitle(isSmall: true),
                  Row(
                    children: const [
                      AudioPreviousButton(),
                      AudioPlayPauseButton(isSmall: true),
                      AudioNextButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
