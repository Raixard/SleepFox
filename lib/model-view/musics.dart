import 'package:sleepfox/model/music.dart';

class Musics {
  static final List<Music> _musics = [
    Music(
      id: "1",
      name: "3-minute Relaxation",
      uriPath: "asset:///assets/music/3-minute_Relaxation.mp3",
      uriArtPath: Uri.parse("assets/music/3-minute_Relaxation.jpg"),
    ),
    Music(
      id: "2",
      name: "5-minute Calm Beaches",
      uriPath: "asset:///assets/music/5-minute_Calm_Beaches.mp3",
      uriArtPath: Uri.parse("assets/music/5-minute_Calm_Beaches.jpg")
    ),
    Music(
      id: "3",
      name: "Calm Wind",
      uriPath: "asset:///assets/music/Calm_Wind.mp3",
      uriArtPath: Uri.parse("assets/music/Calm_Wind.jpg")
    ),
    Music(
      id: "4",
      name: "Ultimate Deep Sleep",
      uriPath: "asset:///assets/music/Ultimate_Deep_Sleep.mp3",
      uriArtPath: Uri.parse("assets/music/Ultimate_Deep_Sleep.jpg")
    ),
    Music(
      id: "5",
      name: "Lo-Fi Song for Relaxing Day",
      uriPath: "asset:///assets/music/Lo-Fi_Song_for_Relaxing_Day.mp3",
      uriArtPath: Uri.parse("assets/music/Lo-Fi_Song_for_Relaxing_Day.jpg")
    ),
  ];

  static List<Music> get music => _musics;
  static void shuffleMusic() {
    _musics.shuffle();
  }
}
