import 'package:flutter/material.dart';
import 'package:sleepfox/utils/widget_styles.dart';

// Card berasio 1 : 1
class CardSquare extends StatelessWidget {
  const CardSquare({
    Key? key,
    this.color1 = Colors.green,
    this.color2 = Colors.lightBlue,
    required this.text,
    this.onTap,
    this.assetImage,
  }) : super(key: key);

  final Color color1;
  final Color color2;
  final String text;
  final Function? onTap;
  final String? assetImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color1,
                color2,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: defaultBorderRadius,
          ),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 1 / 1,
                child: Opacity(
                  opacity: 0.3,
                  child: ClipRRect(
                    borderRadius: defaultBorderRadius,
                    child: Image.asset(
                      assetImage ?? "assets/main_page/music.png",
                      fit: BoxFit.cover,
                    ),
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
                    if (onTap != null) onTap!();
                  },
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    padding: defaultPaddingSmall,
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 18,
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
