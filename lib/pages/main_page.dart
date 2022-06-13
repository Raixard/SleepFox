import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/main_page_controller.dart';
import 'package:sleepfox/getx_controller/music_controller.dart';
import 'package:sleepfox/pages/music_page.dart';
import 'package:sleepfox/pages/timer_page.dart';
import 'package:sleepfox/utils/colors.dart';
import 'package:sleepfox/pages/dashboard_page.dart';
import 'package:sleepfox/pages/gallery_page.dart';
import 'package:sleepfox/pages/profile_page.dart';
import 'package:sleepfox/widgets/audio_bottom_bar.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final mpc = Get.put(MainPageController());
  final mc = Get.put(MusicController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => AnimatedSwitcher(
              transitionBuilder: AnimatedSwitcher.defaultTransitionBuilder,
              switchInCurve: Curves.easeInOut,
              duration: const Duration(milliseconds: 500),
              child: IndexedStack(
                key: ValueKey<int>(mpc.tabIndex.value),
                index: mpc.tabIndex.value,
                children: [
                  DashboardPage(),
                  TimerPage(),
                  GalleryPage(),
                  const MusicPage(),
                  ProfilePage(),
                ],
              ),
            ),
          ),
          const AudioBottomBar(),
        ],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
          backgroundColor: cDarkPurple,
          indicatorColor: cOrange,
        ),
        child: Obx(
          () => NavigationBar(
            selectedIndex: mpc.tabIndex.value,
            onDestinationSelected: mpc.changeTabIndex,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_rounded),
                label: "Beranda",
              ),
              NavigationDestination(
                icon: Icon(Icons.timer_rounded),
                label: "Timer",
              ),
              NavigationDestination(
                icon: Icon(Icons.filter_frames_rounded),
                label: "Galeri",
              ),
              NavigationDestination(
                icon: Icon(Icons.music_note_rounded),
                label: "Musik",
              ),
              NavigationDestination(
                icon: Icon(Icons.person_rounded),
                label: "Profil",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
