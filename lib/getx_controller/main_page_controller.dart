import 'package:get/get.dart';

// Controller untuk bar navigasi utama
class MainPageController extends GetxController {
  // Indeks tab aktif saat ini
  var tabIndex = 0.obs;
  
  void setTabIndex(int index) {
    tabIndex.value = index;
  }
}