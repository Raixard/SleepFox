import 'package:sleepfox/model/music.dart';

class Musics {
  static final List<Music> _musics = [
    Music(
      id: "1",
      name: "Alola!",
      uriPath: "asset:///assets/music/alola.mp3",
      uriArtPath: Uri.parse("assets/gallery/1.jpg"),
    ),
    Music(
      id: "2",
      name: "Pose",
      uriPath: "asset:///assets/music/Pokémon Sun & Moon - Pose.mp3",
      uriArtPath: Uri.parse("assets/gallery/2.jpg")
    ),
    Music(
      id: "3",
      name: "Yuurei Tokyo",
      uriPath: "asset:///assets/music/幽霊東京 _ Ayase (self cover).mp3",
      uriArtPath: Uri.parse("assets/gallery/3.jpg")
    ),
  ];

  static List<Music> get music => _musics;
  static void shuffleMusic() {
    _musics.shuffle();
  }
}
