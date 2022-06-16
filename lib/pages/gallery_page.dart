import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/gallery_controller.dart';
import 'package:sleepfox/getx_controller/music_controller.dart';
import 'package:sleepfox/pages/gallery_add_page.dart';
import 'package:sleepfox/utils/colors.dart';
import 'package:sleepfox/utils/widget_styles.dart';
import 'package:sleepfox/widgets/gallery_post_frame.dart';
import 'package:sleepfox/widgets/main_background.dart';

class GalleryPage extends StatelessWidget {
  GalleryPage({Key? key}) : super(key: key);

  final gc = Get.put(GalleryController());
  final mm = Get.find<MusicController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Galeri"),
        backgroundColor: cDarkPurple.withOpacity(0.5),
        shadowColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: MainBackground(
        child: Stack(
          children: [
            GetBuilder(
              builder: (GalleryController gc) => RefreshIndicator(
                backgroundColor: cOrange,
                color: Colors.white,
                onRefresh: gc.getData,
                child: Padding(
                  padding: defaultPaddingSmall.copyWith(bottom: 0),
                  child: MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    itemCount: gc.galleryPosts.length,
                    itemBuilder: (context, index) {
                      final galleryPost = gc.galleryPosts[index];
                      return GalleryPostFrame(galleryPost);
                    },
                  ),
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
                    onPressed: () {
                      Get.to(() => GalleryAddPage());
                    },
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
