import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sleepfox/getx_controller/user_controller.dart';
import 'package:sleepfox/model/gallery_post.dart';

// Controller untuk mengatur isi galeri
class GalleryController extends GetxController {
  // Isi semua post
  final RxList _galleryPosts = [].obs;

  final _firestore = FirebaseFirestore.instance;
  final _userController = Get.find<UserController>();

  // Dipanggil saat diinisialisasi
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  // Membersihkan database lokal,
  // Membaca data dari database, lalu memasukkannya ke _galleryPosts
  Future<void> getData() async {
    _galleryPosts.clear();
    await FirebaseFirestore.instance
        .collection("gallery_posts")
        .orderBy("timePublished", descending: true)
        .get()
        .then(
          (value) => {
            for (var i in value.docs)
              {
                _galleryPosts.add(
                  GalleryPost(
                    docName: i.id,
                    title: i.get("title"),
                    image: i.get("image"),
                    poster: i.get("poster"),
                    timePublished: i.get("timePublished").toString(),
                  ),
                ),
                _galleryPosts.last.likes.value = i.get("likes"),
              }
          },
        );
    update();
  }

  // Getter _galleryPosts secara penuh
  List get galleryPosts {
    return [..._galleryPosts];
  }

  // Getter _galleryPosts di mana yang diambil
  // hanya milik user saat ini
  List get myGalleryPosts {
    return _galleryPosts
        .where(
            (item) => item.poster == _userController.currentUserId.value.toString())
        .toList();
  }

  // Getter _galleryPosts di mana yang diambil
  // hanya yang disukai oleh user saat ini
  List get likedGalleryPosts {
    return _galleryPosts
        .where((item) =>
            item.likes.value.contains(_userController.currentUserId.value))
        .toList();
  }

  // Fungsi untuk menyukai/tidak menyukai sebuah post
  Future<void> likePost(String postId, String userId, List likes) async {
    try {
      if (likes.contains(userId)) {
        await _firestore.collection("gallery_posts").doc(postId).update({
          "likes": FieldValue.arrayRemove([userId]),
        });
        likes.remove(userId);
      } else {
        await _firestore.collection("gallery_posts").doc(postId).update({
          "likes": FieldValue.arrayUnion([userId]),
        });
        likes.add(userId);
      }
      update();
      // ignore: empty_catches
    } catch (e) {}
  }
}
