import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/models/models.dart';

class ListVisibilityImageAvatar extends StatelessWidget {
  final String avatarUrl;
  final String visibility;

  const ListVisibilityImageAvatar(
      {Key? key, required this.avatarUrl, required this.visibility})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData? iconVis;
    if (visibility == GitLabVisibility.private) {
      iconVis = Icons.lock_outline;
    } else if (visibility == GitLabVisibility.internal) {
      iconVis = Icons.lock_outline;
    } else {
      iconVis = Icons.public;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
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
        ),
        Positioned(
          bottom: -5,
          right: -10,
          child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  // color: Colors.blue.shade700,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Icon(
                iconVis,
                // color: Colors.white,
                size: 14,
              )),
        ),
      ],
    );
  }
}
