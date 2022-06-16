import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/gallery_controller.dart';
import 'package:sleepfox/utils/colors.dart';
import 'package:sleepfox/utils/widget_styles.dart';
import 'package:sleepfox/widgets/image_future_builder.dart';

class GalleryPostPage extends StatelessWidget {
  const GalleryPostPage({
    Key? key,
    required this.image,
    required this.isMyPost,
    required this.docName,
  }) : super(key: key);

  final String image;
  final bool isMyPost;
  final String docName;

  @override
  Widget build(BuildContext context) {
    final gc = Get.put(GalleryController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cDarkPurple.withOpacity(0.5),
        shadowColor: Colors.transparent,
        actions: [
          Visibility(
            visible: isMyPost,
            child: IconButton(
              icon: const Icon(Icons.delete_rounded),
              onPressed: () {
                Get.defaultDialog(
                  title: "Konfirmasi Penghapusan",
                  middleText: "Anda yakin ingin menghapus post ini?",
                  barrierDismissible: false,
                  textConfirm: "Hapus",
                  textCancel: "Batalkan",
                  titlePadding: defaultPadding.copyWith(bottom: 0),
                  contentPadding: defaultPadding,
                  onConfirm: () async {
                    await FirebaseFirestore.instance
                        .collection("gallery_posts")
                        .doc(docName)
                        .delete();
                    await FirebaseStorage.instance.ref().child(image).delete();
                    gc.getData();
                    Get.back(closeOverlays: true);
                  },
                );
              },
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: InteractiveViewer(
          child: ImageFutureBuilder(image),
        ),
      ),
    );
  }
}
