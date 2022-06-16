import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/gallery_form_controller.dart';
import 'package:sleepfox/utils/widget_styles.dart';
import 'package:sleepfox/widgets/small_widgets.dart';

class GalleryAddPage extends StatelessWidget {
  GalleryAddPage({Key? key}) : super(key: key);

  final gfc = Get.put(GalleryFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Gambar"),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () async {
              gfc.postImage();
            },
            child: const Text("Post"),
          ),
        ],
      ),
      body: ListView(
        padding: defaultPadding,
        children: [
          Column(
            children: [
              Obx(
                () => (gfc.filePath.value.isNotEmpty)
                    ? Image.file(gfc.file)
                    : Container(),
              ),
              const SeparatorV(),
              TextInputField(
                controller: gfc.titleController,
                labelText: "Deskripsi gambar",
                icon: const Icon(Icons.title_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
