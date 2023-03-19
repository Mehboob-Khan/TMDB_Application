import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;

  const CustomCachedImage({
    Key? key,
    required this.imageUrl, required int width, required int height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: 100,
      height: 150,
      fit: BoxFit.cover,
      placeholder: (context, url) => Image.asset(
        'assets/images/notfound.png',
        width: 100,
        height: 150,
        fit: BoxFit.cover,
      ),
      errorWidget: (context, url, error) {
        print('Error loading image: $error');
        return Image.asset(
          'assets/images/error_placeholder.png',
          width: 100,
          height: 150,
          fit: BoxFit.cover,
        );
      },
    );
  }
}
