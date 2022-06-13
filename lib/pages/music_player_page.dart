import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/music_controller.dart';
import 'package:sleepfox/utils/colors.dart';
import 'package:sleepfox/utils/widget_styles.dart';
import 'package:sleepfox/widgets/audio_widgets/audio_current_art.dart';
import 'package:sleepfox/widgets/audio_widgets/audio_current_music_title.dart';
import 'package:sleepfox/widgets/audio_widgets/audio_duration_bar.dart';
import 'package:sleepfox/widgets/audio_widgets/audio_loop_button.dart';
import 'package:sleepfox/widgets/audio_widgets/audio_next_button.dart';
import 'package:sleepfox/widgets/audio_widgets/audio_play_pause_button.dart';
import 'package:sleepfox/widgets/audio_widgets/audio_previous_button.dart';
import 'package:sleepfox/widgets/audio_widgets/audio_shuffle_button.dart';
import 'package:sleepfox/widgets/main_background.dart';
import 'package:sleepfox/widgets/small_widgets.dart';

class MusicPlayerPage extends StatelessWidget {
  const MusicPlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mm = Get.find<MusicController>();
    return Stack(
      children: [
        const MainBackground(),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            actions: [
              Obx(
                () => IconButton(
                  tooltip: mm.timerIsOn.value
                      ? "Timer Tidur\nDipilih: ${mm.timeSelected.value} menit"
                      : "Timer Tidur",
                  color: mm.timerIsOn.value ? cOrange : Colors.white,
                  icon: const Icon(Icons.timelapse_rounded),
                  onPressed: () {
                    Get.bottomSheet(
                      BottomSheet(
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
                                        color: mm.timerIsOn.value
                                            ? Colors.white
                                            : cOrange),
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
                                              mm.timeSelected.value ==
                                                  mm.timerPreset[index - 1]
                                          ? cOrange
                                          : Colors.white,
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: Center(
            child: ListView(
              padding: defaultPadding,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onPanUpdate: (details) {
                        // Apabila pengguna scroll ke bawah,
                        // maka akan kembali ke halaman sebelumnya
                        if (details.delta.dy > 10) {
                          Get.back();
                        }
                        // Apabila pengguna scroll ke kanan,
                        // maka akan memainkan musik selanjutnya (jika ada)
                        if (details.delta.dx > 10) {
                          if (mm.audioPlayer.hasNext) {
                            mm.audioPlayer.seekToNext();
                          }
                        }
                        // Apabila pengguna scroll ke kiri,
                        // maka akan memainkan musik sebelumnya (jika ada)
                        if (details.delta.dx < -10) {
                          if (mm.audioPlayer.hasPrevious) {
                            mm.audioPlayer.seekToPrevious();
                          }
                        }
                      },
                      child: const AudioCurrentArt(),
                    ),
                    const SeparatorV(),
                    const AudioCurrentMusicTitle(),
                    const SeparatorV(),
                    const AudioDurationBar(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        AudioLoopButton(),
                        AudioPreviousButton(),
                        AudioPlayPauseButton(),
                        AudioNextButton(),
                        AudioShuffleButton(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
