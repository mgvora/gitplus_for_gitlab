// GENERATED CODE - DO NOT MODIFY BY HAND

import '../src/mode.dart';
import '../src/common_modes.dart';

final stylus = Mode(
    refs: {
      '~contains~4':
          Mode(className: "number", begin: "#([a-fA-F0-9]{6}|[a-fA-F0-9]{3})"),
      '~contains~10': Mode(className: "variable", begin: "\\\$[a-zA-Z]\\w*"),
    },
    aliases: ["styl"],
    case_insensitive: false,
    keywords: "if else for in",
    illegal:
        "(\\?|(\\bReturn\\b)|(\\bEnd\\b)|(\\bend\\b)|(\\bdef\\b)|;|#\\s|\\*\\s|===\\s|\\||%)",
    contains: [
      QUOTE_STRING_MODE,
      APOS_STRING_MODE,
      C_LINE_COMMENT_MODE,
      C_BLOCK_COMMENT_MODE,
      Mode(ref: '~contains~4'),
      Mode(
          begin: "\\.[a-zA-Z][a-zA-Z0-9_-]*(?=[\\.\\s\\n\\[\\:,])",
          className: "selector-class"),
      Mode(
          begin: "\\#[a-zA-Z][a-zA-Z0-9_-]*(?=[\\.\\s\\n\\[\\:,])",
          className: "selector-id"),
      Mode(
          begin:
              "\\b(a|abbr|address|article|aside|audio|b|blockquote|body|button|canvas|caption|cite|code|dd|del|details|dfn|div|dl|dt|em|fieldset|figcaption|figure|footer|form|h1|h2|h3|h4|h5|h6|header|hgroup|html|i|iframe|img|input|ins|kbd|label|legend|li|mark|menu|nav|object|ol|p|q|quote|samp|section|span|strong|summary|sup|table|tbody|td|textarea|tfoot|th|thead|time|tr|ul|var|video)(?=[\\.\\s\\n\\[\\:,])",
          className: "selector-tag"),
      Mode(
          begin:
              "&?:?:\\b(after|before|first-letter|first-line|active|first-child|focus|hover|lang|link|visited)(?=[\\.\\s\\n\\[\\:,])"),
      Mode(
          begin:
              "@(charset|css|debug|extend|font-face|for|import|include|media|mixin|page|warn|while)\\b"),
      Mode(ref: '~contains~10'),
      CSS_NUMBER_MODE,
      NUMBER_MODE,
      Mode(
          className: "function",
          begin: "^[a-zA-Z][a-zA-Z0-9_-]*\\(.*\\)",
          illegal: "[\\n]",
          returnBegin: true,
          contains: [
            Mode(className: "title", begin: "\\b[a-zA-Z][a-zA-Z0-9_-]*"),
            Mode(className: "params", begin: "\\(", end: "\\)", contains: [
              Mode(ref: '~contains~4'),
              Mode(ref: '~contains~10'),
              APOS_STRING_MODE,
              CSS_NUMBER_MODE,
              NUMBER_MODE,
              QUOTE_STRING_MODE
            ])
          ]),
      Mode(
          className: "attribute",
          begin:
              "\\b(z-index|word-wrap|word-spacing|word-break|width|widows|white-space|visibility|vertical-align|unicode-bidi|transition-timing-function|transition-property|transition-duration|transition-delay|transition|transform-style|transform-origin|transform|top|text-underline-position|text-transform|text-shadow|text-rendering|text-overflow|text-indent|text-decoration-style|text-decoration-line|text-decoration-color|text-decoration|text-align-last|text-align|table-layout|tab-size|right|resize|quotes|position|pointer-events|perspective-origin|perspective|page-break-inside|page-break-before|page-break-after|padding-top|padding-right|padding-left|padding-bottom|padding|overflow-y|overflow-x|overflow-wrap|overflow|outline-width|outline-style|outline-offset|outline-color|outline|orphans|order|opacity|object-position|object-fit|normal|none|nav-up|nav-right|nav-left|nav-index|nav-down|min-width|min-height|max-width|max-height|mask|marks|margin-top|margin-right|margin-left|margin-bottom|margin|list-style-type|list-style-position|list-style-image|list-style|line-height|letter-spacing|left|justify-content|initial|inherit|ime-mode|image-resolution|image-rendering|image-orientation|icon|hyphens|height|font-weight|font-variant-ligatures|font-variant|font-style|font-stretch|font-size-adjust|font-size|font-language-override|font-kerning|font-feature-settings|font-family|font|float|flex-wrap|flex-shrink|flex-grow|flex-flow|flex-direction|flex-basis|flex|filter|empty-cells|display|direction|cursor|counter-reset|counter-increment|content|columns|column-width|column-span|column-rule-width|column-rule-style|column-rule-color|column-rule|column-gap|column-fill|column-count|color|clip-path|clip|clear|caption-side|break-inside|break-before|break-after|box-sizing|box-shadow|box-decoration-break|bottom|border-width|border-top-width|border-top-style|border-top-right-radius|border-top-left-radius|border-top-color|border-top|border-style|border-spacing|border-right-width|border-right-style|border-right-color|border-right|border-radius|border-left-width|border-left-style|border-left-color|border-left|border-image-width|border-image-source|border-image-slice|border-image-repeat|border-image-outset|border-image|border-color|border-collapse|border-bottom-width|border-bottom-style|border-bottom-right-radius|border-bottom-left-radius|border-bottom-color|border-bottom|border|background-size|background-repeat|background-position|background-origin|background-image|background-color|background-clip|background-attachment|background|backface-visibility|auto|animation-timing-function|animation-play-state|animation-name|animation-iteration-count|animation-fill-mode|animation-duration|animation-direction|animation-delay|animation|align-self|align-items|align-content)\\b",
          starts: Mode(
              end: ";|\$",
              contains: [
                Mode(ref: '~contains~4'),
                Mode(ref: '~contains~10'),
                APOS_STRING_MODE,
                QUOTE_STRING_MODE,
                CSS_NUMBER_MODE,
                NUMBER_MODE,
                C_BLOCK_COMMENT_MODE
              ],
              illegal: "\\.",
              relevance: 0))
    ]);
