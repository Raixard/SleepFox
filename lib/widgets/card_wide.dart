import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/main_page_controller.dart';
import 'package:sleepfox/utils/widget_styles.dart';

// Card berasio 7 : 3 untuk card galeri
class CardWide extends StatelessWidget {
  const CardWide({
    Key? key,
    this.color1,
    this.color2,
    required this.text,
    this.onTap,
    this.assetImage,
  }) : super(key: key);

  final Color? color1;
  final Color? color2;
  final String text;
  final Function? onTap;
  final String? assetImage;

  @override
  Widget build(BuildContext context) {
    final mpc = Get.find<MainPageController>();
    return AspectRatio(
      aspectRatio: 7 / 3,
      child: ClipRRect(
        borderRadius: defaultBorderRadius,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color1 ?? Colors.blue,
                color2 ?? Colors.green,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Opacity(
                  opacity: 0.4,
                  child: Image.asset(
                    assetImage ?? "assets/main_page/gallery.png",
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: defaultBorderRadius,
                  ),
                  onTap: () {
                    mpc.setTabIndex(2);
                  },
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.all(18),
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
