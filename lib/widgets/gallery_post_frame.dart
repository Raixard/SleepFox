import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/gallery_controller.dart';
import 'package:sleepfox/getx_controller/user_controller.dart';
import 'package:sleepfox/pages/gallery_post_page.dart';
import 'package:sleepfox/utils/colors.dart';
import 'package:sleepfox/utils/widget_styles.dart';
import 'package:sleepfox/widgets/image_future_builder.dart';

class GalleryPostFrame extends StatelessWidget {
  GalleryPostFrame(this.galleryPost, {Key? key}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final galleryPost;
  final gc = Get.put(GalleryController());
  final uc = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: defaultBorderRadius,
              child: ImageFutureBuilder(galleryPost.image),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: defaultBorderRadius,
                  onTap: () {
                    Get.to(
                      () => GalleryPostPage(
                        image: galleryPost.image,
                        isMyPost: galleryPost.poster == uc.currentUserId.value,
                        docName: galleryPost.docName,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(galleryPost.title),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  galleryPost.likes.length.toString(),
                ),
                IconButton(
                  onPressed: () async {
                    await gc.likePost(
                      galleryPost.docName,
                      uc.currentUserId.value,
                      galleryPost.likes,
                    );
                  },
                  highlightColor: cDarkPurple,
                  icon: galleryPost.likes.contains(uc.currentUserId.value)
                      ? const Icon(
                          Icons.thumb_up_rounded,
                          color: cOrange,
                        )
                      : const Icon(Icons.thumb_up_outlined),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
