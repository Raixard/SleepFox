import 'dart:async';

import 'package:get/get.dart';
import 'package:wakelock/wakelock.dart';

class TimerCountdownController extends GetxController {
  var prompts = "".obs;
  var timeLeft = "".obs;
  var indicator = 0.0.obs;
  var inhaling = false.obs;

  late Duration duration;
  late Stopwatch _stopwatch;
  Timer? _timer;
  double _progressToRhythm = 1;

  final double rhythm;
  final int durationMinutes;

  // Constructor
  TimerCountdownController({
    required this.durationMinutes,
    required this.rhythm,
  });

  @override
  void onInit() {
    super.onInit();
    timerStart();
    Wakelock.enable();
  }

  @override
  void onReady() {
    super.onReady();
    inhaling.value = true;
  }

  @override
  void onClose() {
    super.onClose();
    timerStop();
    Wakelock.disable();
  }

  void timerStart() {
    _stopwatch = Stopwatch();

    if (!_stopwatch.isRunning) {
      _stopwatch.start();
    }

    duration = Duration(minutes: durationMinutes, seconds: 1);
    prompts.value = "Tarik nafas";

    _timer = Timer.periodic(
      const Duration(milliseconds: 10),
      (Timer timer) {
        var difference = duration - _stopwatch.elapsed;

        String minutes =
            difference.inMinutes.remainder(60).toString().padLeft(2, "0");
        String seconds =
            difference.inSeconds.remainder(60).toString().padLeft(2, "0");

        timeLeft.value = "$minutes:$seconds";
        indicator.value = _progressToRhythm / rhythm;

        _progressToRhythm++;
        if (inhaling.value && _progressToRhythm >= rhythm) {
          prompts.value = "Keluarkan nafas";
          _progressToRhythm = 1;
          inhaling.value = false;
        } else if (!inhaling.value && _progressToRhythm >= rhythm) {
          prompts.value = "Tarik nafas";
          _progressToRhythm = 1;
          inhaling.value = true;
        }

        if (difference.inMilliseconds <= 0) {
          timerStop();
          Get.back();
        }
      },
    );
  }

  void timerStop() {
    if (!_stopwatch.isRunning) {
      return;
    }
    _timer!.cancel();
    _stopwatch.stop();
  }
}
