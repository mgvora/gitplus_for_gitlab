// GENERATED CODE - DO NOT MODIFY BY HAND

import '../src/mode.dart';
import '../src/common_modes.dart';

final pf = Mode(
    refs: {},
    aliases: ["pf.conf"],
    lexemes: "[a-z0-9_<>-]+",
    keywords: {
      "built_in": "block match pass load anchor|5 antispoof|10 set table",
      "keyword":
          "in out log quick on rdomain inet inet6 proto from port os to routeallow-opts divert-packet divert-reply divert-to flags group icmp-typeicmp6-type label once probability recieved-on rtable prio queuetos tag tagged user keep fragment for os dropaf-to|10 binat-to|10 nat-to|10 rdr-to|10 bitmask least-stats random round-robinsource-hash static-portdup-to reply-to route-toparent bandwidth default min max qlimitblock-policy debug fingerprints hostid limit loginterface optimizationreassemble ruleset-optimization basic none profile skip state-defaultsstate-policy timeoutconst counters persistno modulate synproxy state|5 floating if-bound no-sync pflow|10 sloppysource-track global rule max-src-nodes max-src-states max-src-connmax-src-conn-rate overload flushscrub|5 max-mss min-ttl no-df|10 random-id",
      "literal": "all any no-route self urpf-failed egress|5 unknown"
    },
    contains: [
      HASH_COMMENT_MODE,
      NUMBER_MODE,
      QUOTE_STRING_MODE,
      Mode(className: "variable", begin: "\\\$[\\w\\d#@][\\w\\d_]*"),
      Mode(className: "variable", begin: "<(?!\\/)", end: ">")
    ]);
