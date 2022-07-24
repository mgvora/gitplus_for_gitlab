import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/models/models.dart';

class ListVisibilityTextAvatar extends StatelessWidget {
  final String text;
  final String visibility;

  const ListVisibilityTextAvatar(
      {Key? key, required this.text, required this.visibility})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData? iconVis;
    if (visibility == GitLabVisibility.private) {
      iconVis = FontAwesome.lock;
    } else if (visibility == GitLabVisibility.internal) {
      iconVis = FontAwesome.lock;
    } else {
      iconVis = Icons.public;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(child: Text(text)),
        Positioned(
          bottom: -5,
          right: -10,
          child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  // color: Get.theme.brightness == Brightness.dark
                  //     ? Colors.transparent
                  //     : Colors.blue.shade700,
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
