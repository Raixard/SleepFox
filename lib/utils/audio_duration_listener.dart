import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

// Class untuk melihat progres audio saat ini
// Digunakan untuk bar durasi audio
class DurationState {
  const DurationState({
    required this.progress,
    required this.buffered,
    required this.total,
  });
  final Duration progress;
  final Duration buffered;
  final Duration total;
}

// Class untuk mengawasi progres audio saat ini
// untuk disimpan ke DurationState
class AudioDurationListener {
  final AudioPlayer _audioPlayer;

  // Notifier (pengawas) progres audio
  final progressNotifier = ValueNotifier<DurationState>(
    const DurationState(
      progress: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );

  // Constructor
  AudioDurationListener(this._audioPlayer) {
    _init();
  }

  // Dijalankan saat class dibuat
  void _init() async {
    // Untuk mengawasi posisi audio saat ini
    _audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = DurationState(
        progress: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    },);

    // Untuk mengawasi sejauh mana bagian audio
    // yang telah di-download saat ini
    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = DurationState(
        progress: oldState.progress,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });

    // Untuk mengawasi total durasi audio
    _audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = DurationState(
        progress: oldState.progress,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }
}
