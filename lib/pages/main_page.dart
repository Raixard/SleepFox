import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/main_page_controller.dart';
import 'package:sleepfox/pages/timer_page.dart';
import 'package:sleepfox/utils/colors.dart';
import 'package:sleepfox/pages/dashboard_page.dart';
import 'package:sleepfox/pages/gallery_page.dart';
import 'package:sleepfox/pages/profile_page.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final mpc = Get.put(MainPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: mpc.tabIndex.value,
          children: [
            const DashboardPage(),
            TimerPage(),
            GalleryPage(),
            Center(child: Text(mpc.tabIndex.value.toString())),
            const ProfilePage(),
          ],
        ),
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
                icon: Icon(Icons.dark_mode_rounded),
                label: "Tidur",
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
