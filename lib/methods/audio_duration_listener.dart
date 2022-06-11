import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

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

class AudioDurationListener {
  final AudioPlayer _audioPlayer;

  final progressNotifier = ValueNotifier<DurationState>(
    const DurationState(
      progress: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );

  AudioDurationListener(this._audioPlayer) {
    _init();
  }

  void _init() async {
    _audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = DurationState(
        progress: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    },);

    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = DurationState(
        progress: oldState.progress,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });

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
