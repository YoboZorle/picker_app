import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit boxFit;

  CustomImage({@required this.imageUrl, this.boxFit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: '$imageUrl',
        imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: boxFit),
              ),
            ),
        placeholder: (context, url) => Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[300]),
        errorWidget: (context, url, error) => Container(
            color: Colors.grey[300],
            width: double.infinity,
            height: double.infinity,
            child: Center(child: Icon(Icons.person, color: Colors.grey))));
  }
}
