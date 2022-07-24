// GENERATED CODE - DO NOT MODIFY BY HAND

import '../src/mode.dart';
import '../src/common_modes.dart';

final llvm = Mode(
    refs: {},
    keywords:
        "begin end true false declare define global constant private linker_private internal available_externally linkonce linkonce_odr weak weak_odr appending dllimport dllexport common default hidden protected extern_weak external thread_local zeroinitializer undef null to tail target triple datalayout volatile nuw nsw nnan ninf nsz arcp fast exact inbounds align addrspace section alias module asm sideeffect gc dbg linker_private_weak attributes blockaddress initialexec localdynamic localexec prefix unnamed_addr ccc fastcc coldcc x86_stdcallcc x86_fastcallcc arm_apcscc arm_aapcscc arm_aapcs_vfpcc ptx_device ptx_kernel intel_ocl_bicc msp430_intrcc spir_func spir_kernel x86_64_sysvcc x86_64_win64cc x86_thiscallcc cc c signext zeroext inreg sret nounwind noreturn noalias nocapture byval nest readnone readonly inlinehint noinline alwaysinline optsize ssp sspreq noredzone noimplicitfloat naked builtin cold nobuiltin noduplicate nonlazybind optnone returns_twice sanitize_address sanitize_memory sanitize_thread sspstrong uwtable returned type opaque eq ne slt sgt sle sge ult ugt ule uge oeq one olt ogt ole oge ord uno ueq une x acq_rel acquire alignstack atomic catch cleanup filter inteldialect max min monotonic nand personality release seq_cst singlethread umax umin unordered xchg add fadd sub fsub mul fmul udiv sdiv fdiv urem srem frem shl lshr ashr and or xor icmp fcmp phi call trunc zext sext fptrunc fpext uitofp sitofp fptoui fptosi inttoptr ptrtoint bitcast addrspacecast select va_arg ret br switch invoke unwind unreachable indirectbr landingpad resume malloc alloca free load store getelementptr extractelement insertelement shufflevector getresult extractvalue insertvalue atomicrmw cmpxchg fence argmemonly double",
    contains: [
      Mode(className: "keyword", begin: "i\\d+"),
      Mode(
          className: "comment",
          begin: ";",
          end: "\\n",
          contains: [
            PHRASAL_WORDS_MODE,
            Mode(
                className: "doctag",
                begin: "(?:TODO|FIXME|NOTE|BUG|XXX):",
                relevance: 0)
          ],
          relevance: 0),
      QUOTE_STRING_MODE,
      Mode(
          className: "string",
          variants: [Mode(begin: "\"", end: "[^\\\\]\"")],
          relevance: 0),
      Mode(className: "title", variants: [
        Mode(begin: "@([-a-zA-Z\$._][\\w\\-\$.]*)"),
        Mode(begin: "@\\d+"),
        Mode(begin: "!([-a-zA-Z\$._][\\w\\-\$.]*)"),
        Mode(begin: "!\\d+([-a-zA-Z\$._][\\w\\-\$.]*)")
      ]),
      Mode(className: "symbol", variants: [
        Mode(begin: "%([-a-zA-Z\$._][\\w\\-\$.]*)"),
        Mode(begin: "%\\d+"),
        Mode(begin: "#\\d+")
      ]),
      Mode(
          className: "number",
          variants: [
            Mode(begin: "0[xX][a-fA-F0-9]+"),
            Mode(begin: "-?\\d+(?:[.]\\d+)?(?:[eE][-+]?\\d+(?:[.]\\d+)?)?")
          ],
          relevance: 0)
    ]);
