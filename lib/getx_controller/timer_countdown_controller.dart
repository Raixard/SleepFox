import 'dart:async';

import 'package:get/get.dart';
import 'package:wakelock/wakelock.dart';

// Controller untuk menghitung waktu timer pernapasan
class TimerCountdownController extends GetxController {
  // Perintah
  var prompts = "".obs;
  // Waktu tersisa (teks)
  var timeLeft = "".obs;
  // Bar indikator
  var indicator = 0.0.obs;
  // Mengecek apakah sedang diperintahkan untuk tarik napas
  var inhaling = false.obs;

  late Duration duration;
  late Stopwatch _stopwatch;
  Timer? _timer;
  double _progressToRhythm = 1;

  // Ritme pernapasan
  final double rhythm;
  // Durasi timer (dalam menit)
  final int durationMinutes;

  // Constructor
  TimerCountdownController({
    required this.durationMinutes,
    required this.rhythm,
  });

  // Dijalankan saat controller diinisialisasi
  @override
  void onInit() {
    super.onInit();
    timerStart();
    Wakelock.enable();
  }

  // Dijalankan 1 frame setelah onInit()
  @override
  void onReady() {
    super.onReady();
    inhaling.value = true;
  }

  // Dijalankan setelah controller dihapus
  @override
  void onClose() {
    super.onClose();
    timerStop();
    Wakelock.disable();
  }

  // Menjalankan timer
  void timerStart() {
    _stopwatch = Stopwatch();

    // Memulai stopwatch bila sedang tidak berjalan
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
    }

    // Memulai hitung mundur berdasarkan durasi yang dipilih
    // + 1 detik
    duration = Duration(minutes: durationMinutes, seconds: 1);
    // Mengatur perintah awal
    prompts.value = "Tarik nafas";

    // Membuat timer yang melakukan fungsi secara berkala tiap 10 milidetik
    _timer = Timer.periodic(
      const Duration(milliseconds: 10),
      (Timer timer) {
        // Menghitung waktu tersisa dihitung dihitung dari durasi - stopwatch
        var difference = duration - _stopwatch.elapsed;

        // Mengatur waktu tersisa menjadi bentuk menit dan detik
        String minutes =
            difference.inMinutes.remainder(60).toString().padLeft(2, "0");
        String seconds =
            difference.inSeconds.remainder(60).toString().padLeft(2, "0");

        // Menaruh waktu tersisa
        timeLeft.value = "$minutes:$seconds";

        // Menghitung progres bar indikator
        indicator.value = _progressToRhythm / rhythm;

        // Meningkatkan progres ritme pernapasan
        _progressToRhythm++;

        // Bila telah mencapai ritme, proges ritme akan diulang
        // dan perintah akan diubah sesuai perintah saat ini
        if (inhaling.value && _progressToRhythm >= rhythm) {
          prompts.value = "Keluarkan nafas";
          _progressToRhythm = 1;
          inhaling.value = false;
        } else if (!inhaling.value && _progressToRhythm >= rhythm) {
          prompts.value = "Tarik nafas";
          _progressToRhythm = 1;
          inhaling.value = true;
        }

        // Bila perbedaan / waktu tersisa sudah mencapai 0,
        // timer akan dihentikan dan pengguna akan dibawa
        // ke halama sebelumnya
        if (difference.inMilliseconds <= 0) {
          timerStop();
          Get.back();
        }
      },
    );
  }

  // Menghentikan timer
  void timerStop() {
    if (!_stopwatch.isRunning) {
      return;
    }
    _timer!.cancel();
    _stopwatch.stop();
  }
}
