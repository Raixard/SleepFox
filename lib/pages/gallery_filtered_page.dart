import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/gallery_controller.dart';
import 'package:sleepfox/getx_controller/user_controller.dart';
import 'package:sleepfox/utils/colors.dart';
import 'package:sleepfox/utils/widget_styles.dart';
import 'package:sleepfox/widgets/gallery_post_frame.dart';
import 'package:sleepfox/widgets/main_background.dart';

class GalleryFilteredPage extends StatelessWidget {
  GalleryFilteredPage({
    Key? key,
    required this.isLikedPostsGallery,
  }) : super(key: key);

  final bool isLikedPostsGallery;
  final gc = Get.put(GalleryController());
  final uc = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isLikedPostsGallery ? "Gambar Disukai" : "Gambar Saya",
        ),
        backgroundColor: cDarkPurple.withOpacity(0.5),
        shadowColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: MainBackground(
        child: GetBuilder(
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
                itemCount: isLikedPostsGallery
                    ? gc.likedGalleryPosts.length
                    : gc.myGalleryPosts.length,
                itemBuilder: (context, index) {
                  final galleryPost = isLikedPostsGallery
                      ? gc.likedGalleryPosts[index]
                      : gc.myGalleryPosts[index];
                  return GalleryPostFrame(galleryPost);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
