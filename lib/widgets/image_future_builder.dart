import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sleepfox/utils/image_service.dart';

class ImageFutureBuilder extends StatelessWidget {
  const ImageFutureBuilder(this.image, {Key? key}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ImageService.getImageURL(image),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        return CachedNetworkImage(
          imageUrl: snapshot.data!,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      },
    );
  }
}
