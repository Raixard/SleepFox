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
      () => AnimatedContainer(
        alignment: mm.bottomBarVisibility.value
            ? Alignment.bottomCenter
            : const Alignment(0, 2),
        padding: defaultPaddingSmall,
        curve: Curves.easeInOut,
        duration: const Duration(seconds: 1),
        child: AnimatedOpacity(
          opacity: mm.bottomBarVisibility.value ? 1 : 0,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              color: cDarkPurple.withOpacity(0.5),
              borderRadius: defaultBorderRadius,
            ),
            child: GestureDetector(
              onTap: () {
                Get.to(
                  () => const MusicPlayerPage(),
                  transition: Transition.fade,
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 500),
                );
              },
              onPanUpdate: (details) {
                // Apabila pengguna melakukan scroll ke bawah
                // bar musik kecil akan ditutup
                if (details.delta.dy > 10) {
                  // Menghentikan audio player
                  mm.audioPlayer.stop();
                  // Menyembunyikan bar musik
                  mm.bottomBarVisibility.value = false;
                }
                // Apabila pengguna melakukan scroll ke atas,
                // akan pergi ke tampilan music player
                if (details.delta.dy < -10) {
                  Get.to(
                    () => const MusicPlayerPage(),
                    transition: Transition.fade,
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 500),
                  );
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
                  const Expanded(
                    child: AudioCurrentMusicTitle(isSmall: true),
                  ),
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
