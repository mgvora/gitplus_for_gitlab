// GENERATED CODE - DO NOT MODIFY BY HAND

import '../src/mode.dart';
import '../src/common_modes.dart';

final xl = Mode(
    refs: {
      '~contains~2':
          Mode(className: "string", begin: "\"", end: "\"", illegal: "\\n"),
    },
    aliases: ["tao"],
    lexemes: "[a-zA-Z][a-zA-Z0-9_?]*",
    keywords: {
      "keyword":
          "if then else do while until for loop import with is as where when by data constant integer real text name boolean symbol infix prefix postfix block tree",
      "literal": "true false nil",
      "built_in":
          "in mod rem and or xor not abs sign floor ceil sqrt sin cos tan asin acos atan exp expm1 log log2 log10 log1p pi at text_length text_range text_find text_replace contains page slide basic_slide title_slide title subtitle fade_in fade_out fade_at clear_color color line_color line_width texture_wrap texture_transform texture scale_?x scale_?y scale_?z? translate_?x translate_?y translate_?z? rotate_?x rotate_?y rotate_?z? rectangle circle ellipse sphere path line_to move_to quad_to curve_to theme background contents locally time mouse_?x mouse_?y mouse_buttons ObjectLoader Animate MovieCredits Slides Filters Shading Materials LensFlare Mapping VLCAudioVideo StereoDecoder PointCloud NetworkAccess RemoteControl RegExp ChromaKey Snowfall NodeJS Speech Charts"
    },
    contains: [
      C_LINE_COMMENT_MODE,
      C_BLOCK_COMMENT_MODE,
      Mode(ref: '~contains~2'),
      Mode(className: "string", begin: "'", end: "'", illegal: "\\n"),
      Mode(className: "string", begin: "<<", end: ">>"),
      Mode(
          className: "function",
          begin: "[a-z][^\\n]*->",
          returnBegin: true,
          end: "->",
          contains: [
            Mode(
                className: "title",
                begin: "[a-zA-Z]\\w*",
                relevance: 0,
                starts: Mode(endsWithParent: true, keywords: {
                  "keyword":
                      "if then else do while until for loop import with is as where when by data constant integer real text name boolean symbol infix prefix postfix block tree",
                  "literal": "true false nil",
                  "built_in":
                      "in mod rem and or xor not abs sign floor ceil sqrt sin cos tan asin acos atan exp expm1 log log2 log10 log1p pi at text_length text_range text_find text_replace contains page slide basic_slide title_slide title subtitle fade_in fade_out fade_at clear_color color line_color line_width texture_wrap texture_transform texture scale_?x scale_?y scale_?z? translate_?x translate_?y translate_?z? rotate_?x rotate_?y rotate_?z? rectangle circle ellipse sphere path line_to move_to quad_to curve_to theme background contents locally time mouse_?x mouse_?y mouse_buttons ObjectLoader Animate MovieCredits Slides Filters Shading Materials LensFlare Mapping VLCAudioVideo StereoDecoder PointCloud NetworkAccess RemoteControl RegExp ChromaKey Snowfall NodeJS Speech Charts"
                }))
          ]),
      Mode(beginKeywords: "import", end: "\$", keywords: {
        "keyword":
            "if then else do while until for loop import with is as where when by data constant integer real text name boolean symbol infix prefix postfix block tree",
        "literal": "true false nil",
        "built_in":
            "in mod rem and or xor not abs sign floor ceil sqrt sin cos tan asin acos atan exp expm1 log log2 log10 log1p pi at text_length text_range text_find text_replace contains page slide basic_slide title_slide title subtitle fade_in fade_out fade_at clear_color color line_color line_width texture_wrap texture_transform texture scale_?x scale_?y scale_?z? translate_?x translate_?y translate_?z? rotate_?x rotate_?y rotate_?z? rectangle circle ellipse sphere path line_to move_to quad_to curve_to theme background contents locally time mouse_?x mouse_?y mouse_buttons ObjectLoader Animate MovieCredits Slides Filters Shading Materials LensFlare Mapping VLCAudioVideo StereoDecoder PointCloud NetworkAccess RemoteControl RegExp ChromaKey Snowfall NodeJS Speech Charts"
      }, contains: [
        Mode(ref: '~contains~2')
      ]),
      Mode(
          className: "number",
          begin: "[0-9]+#[0-9A-Z_]+(\\.[0-9-A-Z_]+)?#?([Ee][+-]?[0-9]+)?"),
      NUMBER_MODE
    ]);
