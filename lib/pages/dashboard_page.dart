import 'package:flutter/material.dart';
import 'package:sleepfox/utils/widget_styles.dart';
import 'package:sleepfox/widgets/main_background.dart';
import 'package:sleepfox/widgets/small_widgets.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainBackground(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: MediaQuery.of(context).size.height * 0.25,
              backgroundColor: Colors.transparent,
              flexibleSpace: Container(
                padding: defaultPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset("assets/main_page/moon.png"),
                      ),
                    ),
                    const Text(
                      "Halo,",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    const Text(
                      "Hengki Wisnuwibowo",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: defaultPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const GalleryCard(),
                        const SeparatorV(),
                        const Text(
                          "Baru Saja Didengar",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SeparatorV(small: true),
                        SingleChildScrollView(
                          clipBehavior: Clip.none,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: const [
                              CardOneToOne(
                                text: "Nafsu",
                                color1: Colors.red,
                                color2: Colors.purple,
                              ),
                              SizedBox(width: 16),
                              CardOneToOne(
                                text: "Ketenangan Tiada Tara",
                                color1: Colors.green,
                                color2: Colors.purple,
                              ),
                              SizedBox(width: 16),
                              CardOneToOne(
                                text: "Hebat",
                                color1: Colors.lightBlue,
                                color2: Colors.lightGreen,
                              ),
                              SizedBox(width: 16),
                              CardOneToOne(
                                text: "Tusuynass",
                                color1: Colors.yellow,
                                color2: Colors.brown,
                              ),
                            ],
                          ),
                        ),
                        const SeparatorV(),
                        const Text(
                          "Terpopuler",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SeparatorV(small: true),
                        SingleChildScrollView(
                          clipBehavior: Clip.none,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: const [
                              CardOneToOne(
                                text: "Nafsu",
                                color1: Colors.red,
                                color2: Colors.purple,
                              ),
                              SizedBox(width: 16),
                              CardOneToOne(
                                text: "Ketenangan",
                                color1: Colors.green,
                                color2: Colors.purple,
                              ),
                              SizedBox(width: 16),
                              CardOneToOne(
                                text: "Hebat",
                                color1: Colors.lightBlue,
                                color2: Colors.lightGreen,
                              ),
                              SizedBox(width: 16),
                              CardOneToOne(
                                text: "Tusuynass",
                                color1: Colors.yellow,
                                color2: Colors.brown,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardOneToOne extends StatelessWidget {
  const CardOneToOne({
    Key? key,
    this.color1 = Colors.green,
    this.color2 = Colors.lightBlue,
    required this.text,
  }) : super(key: key);

  final Color color1;
  final Color color2;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
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
              Align(
                alignment: Alignment.bottomRight,
                child: Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    "assets/main_page/music.png",
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: defaultBorderRadius,
                  ),
                  onTap: () {},
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

class GalleryCard extends StatelessWidget {
  const GalleryCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 7 / 3,
      child: ClipRRect(
        borderRadius: defaultBorderRadius,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green,
                Colors.lightBlue,
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
                    "assets/main_page/gallery.png",
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
                  },
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.all(18),
                    child: const Text(
                      "Galeri",
                      style: TextStyle(
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
