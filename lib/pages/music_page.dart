import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:sleepfox/getx_controller/music_controller.dart';
import 'package:sleepfox/utils/colors.dart';
import 'package:sleepfox/utils/widget_styles.dart';
import 'package:sleepfox/widgets/card_square.dart';
import 'package:sleepfox/widgets/main_background.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mm = Get.find<MusicController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Musik"),
        backgroundColor: cDarkPurple.withOpacity(0.5),
        shadowColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: MainBackground(
        child: Padding(
          padding: defaultPaddingSmall.copyWith(bottom: 0),
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: List.generate(
              mm.playlist.length,
              (index) {
                final tag =
                    mm.playlist.children[index].sequence.first.tag as MediaItem;
                return CardSquare(
                  text: tag.title,
                  color1: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                  color2: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                  assetImage: tag.artUri.toString(),
                  onTap: () {
                    mm.playSelected(tag.id);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
