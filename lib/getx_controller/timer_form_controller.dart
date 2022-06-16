import 'package:get/get.dart';

// Controller untuk form timer pernapasan
class TimerFormController extends GetxController {
  // Ritme pernapasan
  var rhythm = 4.obs;
  // Durasi timer
  var duration = 5.obs;

  // Durasi yang bisa dipilih pengguna (dalam menit)
  final durationPresets = [1, 2, 3, 5, 10];
  // Ritme yang bisa dipilih pengguna (dalam detik)
  final rhythmPresets = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  void setDuration(int value) {
    duration.value = value;
  }

  void setRhythm(int value) {
    rhythm.value = value;
  }
}