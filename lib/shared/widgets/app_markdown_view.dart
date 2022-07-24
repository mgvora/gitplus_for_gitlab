import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class AppMarkdown extends StatelessWidget {
  final String content;
  const AppMarkdown({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Markdown(
      data: content,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      onTapLink: (text, href, title) {
        if (href == null || !GetUtils.isURL(href)) {
          return;
        }
        launchUrl(Uri.parse((href)));
      },
      imageBuilder: (u, x, y) {
        if (u.toString().contains('svg')) {
          return SvgPicture.network(u.toString());
        } else if (GetUtils.isURL(u.toString())) {
          return CachedNetworkImage(imageUrl: u.toString());
        } else {
          return Container();
        }
      },
      physics: const NeverScrollableScrollPhysics(),
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
        code: const TextStyle(fontFamily: 'SourceCodePro'),
      ),
      onTapText: () {},
    );
  }
}
