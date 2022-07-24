import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/shared/flutter_highlight/flutter_highlight.dart';
import 'package:gitplus_for_gitlab/shared/flutter_highlight/theme_map.dart';
import 'package:gitplus_for_gitlab/shared/utils/common_widget.dart';

class AppHighlightView extends StatelessWidget {
  final String? content;
  final String lang;
  final double? fontSize;
  final String? theme;
  final bool? lineNumbers;

  const AppHighlightView({
    Key? key,
    this.content,
    required this.lang,
    this.fontSize,
    this.theme,
    this.lineNumbers = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numLines = '\n'.allMatches(content ?? '').length + 1;

    return content == null || content!.isEmpty
        ? Container()
        : Row(
            children: [
              if (lineNumbers!) const SizedBox(width: 10),
              if (lineNumbers!)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (var i = 1; i < numLines + 1; i++)
                      Text(i.toString(),
                          style: TextStyle(
                              fontFamily: 'SourceCodePro',
                              fontSize: fontSize,
                              color: Get.theme.hintColor)),
                  ],
                ),
              GestureDetector(
                onDoubleTap: () {
                  Clipboard.setData(ClipboardData(text: content));
                  CommonWidget.toast('Copied to Clipboard');
                },
                child: HighlightView(
                  content!,
                  language: lang,
                  theme: themeMap[theme] ?? {},
                  padding: const EdgeInsets.all(15),
                  textStyle: TextStyle(
                      fontSize: fontSize, fontFamily: 'SourceCodePro'),
                  tabSize: 4,
                ),
              ),
            ],
          );
  }
}
