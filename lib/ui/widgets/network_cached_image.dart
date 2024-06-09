import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkCachedImage extends StatelessWidget {
  const NetworkCachedImage(
      {super.key,
      required this.url,
      required this.fit,
      required this.height,
      required this.width});

  final String url;
  final Double? height;
  final Double? width;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      progressIndicatorBuilder: (_, __, ___) {
        return const CircularProgressIndicator();
      },
      errorWidget: (_, __, ___) {
        return const Icon(Icons.error_outline);
      },
    );
  }
}
