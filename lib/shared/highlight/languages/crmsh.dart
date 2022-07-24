// GENERATED CODE - DO NOT MODIFY BY HAND

import '../src/mode.dart';
import '../src/common_modes.dart';

final crmsh = Mode(
    refs: {},
    aliases: ["crm", "pcmk"],
    case_insensitive: true,
    keywords: {
      "keyword":
          "params meta operations op rule attributes utilization read write deny defined not_defined in_range date spec in ref reference attribute type xpath version and or lt gt tag lte gte eq ne \\ number string",
      "literal":
          "Master Started Slave Stopped start promote demote stop monitor true false"
    },
    contains: [
      HASH_COMMENT_MODE,
      Mode(
          beginKeywords: "node",
          starts: Mode(
              end: "\\s*([\\w_-]+:)?",
              starts: Mode(className: "title", end: "\\s*[\\\$\\w_][\\w_-]*"))),
      Mode(
          beginKeywords: "primitive rsc_template",
          starts: Mode(
              className: "title",
              end: "\\s*[\\\$\\w_][\\w_-]*",
              starts: Mode(end: "\\s*@?[\\w_][\\w_\\.:-]*"))),
      Mode(
          begin:
              "\\b(group|clone|ms|master|location|colocation|order|fencing_topology|rsc_ticket|acl_target|acl_group|user|role|tag|xml)\\s+",
          keywords:
              "group clone ms master location colocation order fencing_topology rsc_ticket acl_target acl_group user role tag xml",
          starts: Mode(className: "title", end: "[\\\$\\w_][\\w_-]*")),
      Mode(
          beginKeywords: "property rsc_defaults op_defaults",
          starts: Mode(className: "title", end: "\\s*([\\w_-]+:)?")),
      QUOTE_STRING_MODE,
      Mode(
          className: "meta",
          begin: "(ocf|systemd|service|lsb):[\\w_:-]+",
          relevance: 0),
      Mode(
          className: "number",
          begin: "\\b\\d+(\\.\\d+)?(ms|s|h|m)?",
          relevance: 0),
      Mode(className: "literal", begin: "[-]?(infinity|inf)", relevance: 0),
      Mode(
          className: "attr",
          begin: "([A-Za-z\\\$_\\#][\\w_-]+)=",
          relevance: 0),
      Mode(className: "tag", begin: "</?", end: "/?>", relevance: 0)
    ]);
