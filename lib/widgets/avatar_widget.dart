import 'package:cached_firestorage/remote_picture.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/user_controller.dart';
import 'package:sleepfox/utils/colors.dart';

// Widget untuk menampilkan foto profil di halaman edit profil
// menerima parameter showEditIcon untuk menampilkan icon edit atau tidak
// serta fungsi yang dijalankan ketika tombol edit ditekan
class AvatarWidget extends StatelessWidget {
  final bool showEditIcon;
  final VoidCallback onClicked;

  AvatarWidget({Key? key, required this.showEditIcon, required this.onClicked})
      : super(key: key);

  final UserController userCtrl = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Center(child: buildStack(MediaQuery.of(context).size.width / 6));
  }

  Widget buildStack(radius) {
    if (showEditIcon) {
      return Stack(
        children: [
          buildImage(radius),
          Positioned(bottom: 0, right: 4, child: buildEditIcon(cDarkPurple))
        ],
      );
    } else {
      return buildImage(radius);
    }
  }

  Widget buildImage(radius) {
    return SizedBox(
        width: radius * 2,
        child: AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: Obx(() => userCtrl.imageEdited.isTrue
                    ? Image.file(
                        userCtrl.file,
                        fit: BoxFit.cover,
                      )
                    : RemotePicture(
                        imagePath: userCtrl.image.value,
                        mapKey: userCtrl.image.value
                            .replaceFirst("avatar_image/", ""),
                        fit: BoxFit.cover,
                        placeholder: "assets/profile/hibernating_fox.png",
                      )))));
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: const Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: InkWell(
          onTap: onClicked,
          child: Container(
            padding: EdgeInsets.all(all),
            color: color,
            child: child,
          ),
        ),
      );
}
