import 'dart:async';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:sleepfox/model-view/musics.dart';

// GetxController untuk mengatur musik pada aplikasi
class MusicController extends GetxController {
  // Untuk menampilkan bar kecil untuk musik di bagian bawah layar
  var bottomBarVisibility = false.obs;
  // Untuk memeriksa apakah timer menyala
  var timerIsOn = false.obs;
  // Untuk memeriksa menit timer yang dipilih
  var timeSelected = 0.obs;

  // Audio player utama
  final AudioPlayer audioPlayer = AudioPlayer();
  // Playlist
  late ConcatenatingAudioSource _playlist;
  // Timer agar audio playernya mati otomatis
  Timer? _timer;
  // List waktu timer
  final List<int> _timerPreset = [1, 15, 30, 45, 60, 75, 90, 105, 120];

  // Dijalankan saat controller dibuat
  @override
  void onInit() {
    super.onInit();
    setInitialPlaylist();
  }

  // Audio akan mati bila controller-nya ditutup
  @override
  void onClose() {
    super.onClose();
    audioPlayer.stop();
  }

  // Untuk set playlist
  void setInitialPlaylist() async {
    // Melakukan shuffle pada list lagu
    Musics.shuffleMusic();
    // Memasukkan musik yang sudah di-shuffle ke playlist
    await audioPlayer.setAudioSource(
      _playlist = ConcatenatingAudioSource(
        useLazyPreparation: true,
        children: initialPlaylist,
      ),
    );
  }

  // Getter playlist
  ConcatenatingAudioSource get playlist => _playlist;

  // Getter list timer presets
  List<int> get timerPreset => _timerPreset;

  // Getter untuk playlist dari class Musics
  List<AudioSource> get initialPlaylist => Musics.music.map(
        (e) {
          return AudioSource.uri(
            Uri.parse(e.uriPath),
            tag: MediaItem(
              id: e.id,
              title: e.name,
              artUri: e.uriArtPath,
            ),
          );
        },
      ).toList();

  // Mencari indeks musik pada playlist berdasarkan tag id
  int seekById(String id) {
    for (var i = 0; i < _playlist.length; i++) {
      // Mengambil tag dari item
      var tag = _playlist.children[i].sequence.first.tag as MediaItem;
      // Bila id dari tag sama dengan parameter,
      // akan me-return indeks i
      if (tag.id == id) {
        return i;
      }
    }
    return 0;
  }

  // Memainkan musik yang dipilih
  void playSelected(String id) {
    // Shuffle playlist
    setInitialPlaylist();
    // Memindahkan musik yang dipilih ke indeks pertama
    _playlist.move(seekById(id), 0);
    // Memindahkan posisi player ke musik indeks pertama di durasi 0:00
    audioPlayer.seek(Duration.zero, index: 0);
    // Memainkan musik
    audioPlayer.play();
    // Menampilkan bar kecil musik
    bottomBarVisibility.value = true;
  }

  // Mengatur sleep timer
  void setTimer(int minutes) async {
    // Bila ada timer yang jalan, akan dibatalkan
    if (_timer != null) {
      _timer!.cancel();
    }

    if (minutes > 0) {
      // Menyalakan penanda timer berjalan
      timerIsOn.value = true;
      // Memasukkan menit ke penanda waktu yang dipilih
      timeSelected.value = minutes;
      // Menjalankan timer sebanyak parameter minutes
      _timer = Timer(
        Duration(minutes: minutes),
        () {
          // Menghentikan audio player dan menghentikan penanda
          // saat timer mencapai durasi yang ditentukan
          audioPlayer.stop();
          timerIsOn.value = false;
        },
      );
    } else {
      // Mematikan timer bila minutes = 0
      timerIsOn.value = false;
      _timer = null;
    }
  }
}
