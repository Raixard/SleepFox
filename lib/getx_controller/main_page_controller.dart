import 'package:get/get.dart';

// Controller untuk bar navigasi utama
class MainPageController extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}