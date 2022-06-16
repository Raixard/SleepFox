import 'package:get/get.dart';

class GalleryPost {
  String docName;
  String title;
  String image;
  String poster;
  RxList likes = [].obs;
  String timePublished;

  GalleryPost({
    required this.docName,
    required this.title,
    required this.image,
    required this.poster,
    required this.timePublished,
  });
}