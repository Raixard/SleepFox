import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:sleepfox/model-view/musics.dart';

// GetxController untuk mengatur musik pada aplikasi
class MusicController extends GetxController {
  // Untuk menampilkan bar kecil untuk musik di bagian bawah layar
  var bottomBarVisibility = false.obs;

  // Audio player utama
  final AudioPlayer audioPlayer = AudioPlayer();
  // Playlist
  late ConcatenatingAudioSource _playlist;

  // Dijalankan saat controller dibuat
  @override
  void onInit() {
    super.onInit();
    setInitialPlaylist();
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
      var tag = _playlist.children[i].sequence.first.tag as MediaItem;
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
}
