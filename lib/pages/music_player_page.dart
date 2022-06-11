import 'package:flutter/material.dart';
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
    return Stack(
      children: [
        const MainBackground(),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
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
                    const AudioCurrentArt(),
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
