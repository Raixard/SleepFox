class Music {
  String id;
  String name;
  String uriPath;
  Uri? uriArtPath;

  Music({
    required this.id,
    required this.name,
    required this.uriPath,
    this.uriArtPath,
  }) {
    uriArtPath ??= Uri.parse("assets/gallery/1.jpg");
  }
}
