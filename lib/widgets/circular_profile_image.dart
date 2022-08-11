import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularProfileImage extends StatelessWidget {
  const CircularProfileImage({super.key, this.photoUrl, this.newImage});
  final String? photoUrl;
  final File? newImage;

  @override
  Widget build(BuildContext context) {
    return photoUrl != null
        ? CachedNetworkImage(
            height: 90,
            width: 90,
            imageUrl: photoUrl!,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )
        : Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(newImage!),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle,
            ),
            height: 90,
            width: 90,
          );
  }
}
