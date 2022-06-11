import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/music_controller.dart';
import 'package:sleepfox/utils/colors.dart';
import 'package:sleepfox/utils/widget_styles.dart';
import 'package:sleepfox/widgets/main_background.dart';

class GalleryPage extends StatelessWidget {
  GalleryPage({Key? key}) : super(key: key);

  final _imageLinkList = [
    "assets/gallery/1.jpg",
    "assets/gallery/2.jpg",
    "assets/gallery/3.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final mm = Get.find<MusicController>();
    final imageList = List.generate(
        50, (index) => _imageLinkList[Random().nextInt(_imageLinkList.length)]);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Galeri"),
        backgroundColor: cDarkPurple.withOpacity(0.5),
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            tooltip: "Kembali ke atas",
            onPressed: () {},
            icon: const Icon(Icons.arrow_upward_rounded),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: MainBackground(
        child: Stack(
          children: [
            RefreshIndicator(
              backgroundColor: cOrange,
              color: Colors.white,
              onRefresh: () async {},
              child: Padding(
                padding: defaultPaddingSmall.copyWith(bottom: 0),
                child: MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: defaultBorderRadius,
                              child: Image.asset(imageList[index]),
                            ),
                            Positioned.fill(
                              child: Stack(
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: defaultBorderRadius,
                                      onTap: () {},
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Random().nextBool()
                                          ? const Icon(Icons.thumb_up_rounded)
                                          : const Icon(Icons.thumb_up_outlined),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: defaultPaddingSmall.copyWith(top: 8),
                          child: Text(index.toString()),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Obx(
                () => Padding(
                  padding: mm.bottomBarVisibility.value
                      ? defaultPadding.copyWith(bottom: 96)
                      : defaultPadding,
                  child: FloatingActionButton(
                    tooltip: "Unggah Gambar Baru",
                    backgroundColor: cOrange,
                    foregroundColor: Colors.white,
                    onPressed: () {},
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
