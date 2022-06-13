import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:sleepfox/getx_controller/music_controller.dart';
import 'package:sleepfox/getx_controller/user_controller.dart';
import 'package:sleepfox/utils/widget_styles.dart';
import 'package:sleepfox/widgets/card_square.dart';
import 'package:sleepfox/widgets/card_wide.dart';
import 'package:sleepfox/widgets/main_background.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);

  final UserController userCtrl = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final mm = Get.find<MusicController>();
    return Scaffold(
      body: MainBackground(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: MediaQuery.of(context).size.height * 0.25,
              backgroundColor: Colors.transparent,
              flexibleSpace: Container(
                padding: defaultPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset("assets/main_page/moon.png"),
                      ),
                    ),
                    const Text(
                      "Halo,",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Obx(
                      () => Text(
                        userCtrl.name.value,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: defaultPadding,
                        child: CardWide(
                          text: "Galeri",
                        ),
                      ),
                      const Padding(
                        padding: defaultPadding,
                        child: Text(
                          "Musik Untukmu",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 128,
                        child: ListView.separated(
                          padding: defaultPadding.copyWith(top: 0, bottom: 0),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final tag = mm.playlist.children[index].sequence
                                .first.tag as MediaItem;
                            return CardSquare(
                              text: tag.title,
                              color1: Colors.primaries[
                                  Random().nextInt(Colors.primaries.length)],
                              color2: Colors.primaries[
                                  Random().nextInt(Colors.primaries.length)],
                              assetImage: tag.artUri.toString(),
                              onTap: () {
                                mm.playSelected(tag.id);
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 16);
                          },
                          itemCount: mm.playlist.length.clamp(1, 6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Obx(
              () => SliverVisibility(
                visible: mm.bottomBarVisibility.value,
                sliver: const SliverPadding(
                  padding: EdgeInsets.only(top: 72),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
