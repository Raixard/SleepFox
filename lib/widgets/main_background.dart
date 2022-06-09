import 'package:flutter/material.dart';
import 'package:sleepfox/utils/colors.dart';

// Sebagai background utama untuk banyak page

class MainBackground extends StatelessWidget {
  const MainBackground({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/main_page/stars.png",
          ),
          repeat: ImageRepeat.repeat,
        ),
        gradient: LinearGradient(
          colors: [
            cDarkPurple,
            cLightPurple,
            cDarkPurple,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
