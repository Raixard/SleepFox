import 'package:get/get.dart';

class TimerFormController extends GetxController {
  var rhythm = 4.obs;
  var duration = 5.obs;

  final durationPresets = [1, 2, 3, 5, 10];
  final rhythmPresets = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  void setDuration(int value) {
    duration.value = value;
  }

  void setRhythm(int value) {
    rhythm.value = value;
  }
}