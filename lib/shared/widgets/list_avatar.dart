import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListAvatar extends StatelessWidget {
  final String avatarUrl;

  const ListAvatar({Key? key, required this.avatarUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      child: CachedNetworkImage(
        color: Colors.transparent,
        imageUrl: avatarUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(image: imageProvider),
          ),
        ),
      ),
    );
  }
}
