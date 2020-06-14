
(* So this works well enough in utop.  *)


open Bap.Std
open Core_kernel

let foo = Project.available_readers ()

``` val foo : Project.info list =
  [("marshal", `Ver "2.0.0", Some "OCaml standard marshaling format")] ```

let foo = Project.Input.available_loaders ()

`val foo : string list = ["raw"; "llvm"; "bap-elf"]`

let proj = Project.Input.file ~loader:"llvm" ~filename:"/home/user/VENGEUR/Documents/BAP/BAP_2/first_lisp/inprint" |> Project.create |> ok_exn;;
(* val proj : project = <abstr>  *)

let prog = Project.program proj;;
(*
```
val prog : program term = 000007d6: program
000007bf: sub .plt()
000000a6: 
000000ad: #11 := mem[0x601008, el]:u64
000000b0: RSP := RSP - 8
000000b3: mem := mem with [RSP, el]:u64 <- #11
000000bb: call mem[0x601010, el]:u64 with noreturn


000007c0: sub __do_global_dtors_aux()
000002fd: 
00000308: #36 := mem[0x601030]
0000030b: CF := mem[0x601030] < 0
0000030e: OF := high:1[mem[0x601030] & (mem[0x601030] ^ #36)]
00000311: AF := 0x10 = (0x10 & (#36 ^ mem[0x601030]))
00000314: PF := ~low:1[let $1 = #36 >> 4 ^ #36 in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
00000317: SF := high:1[#36]
0000031a: ZF := 0 = #36
00000324: when ~ZF goto %0000031e
000007c1: goto %0000067f

0000031e: 
00000330: #38 := mem[RSP, el]:u64
00000333: RSP := RSP + 8
00000337: call #38 with noreturn

0000067f: 
00000686: #75 := RBP
00000689: RSP := RSP - 8
0000068c: mem := mem with [RSP, el]:u64 <- #75
00000693: RBP := RSP
0000069c: RSP := RSP - 8
0000069f: mem := mem with [RSP, el]:u64 <- 0x4004A2
000006a2: call @deregister_tm_clones with return %000006a4

000006a4: 
000006a9: mem := mem with [0x601030] <- 1
000006b1: RBP := mem[RSP, el]:u64
000006b4: RSP := RSP + 8
000006bd: #76 := mem[RSP, el]:u64
000006c0: RSP := RSP + 8
000006c4: call #76 with noreturn


000007c2: sub __libc_csu_fini()
000005d5: 
000005dc: #68 := mem[RSP, el]:u64
000005df: RSP := RSP + 8
000005e3: call #68 with noreturn


000007c3: sub __libc_csu_init()
00000435: 
0000043c: #48 := R15
0000043f: RSP := RSP - 8
00000442: mem := mem with [RSP, el]:u64 <- #48
0000044b: #49 := R14
0000044e: RSP := RSP - 8
00000451: mem := mem with [RSP, el]:u64 <- #49
00000458: R15 := RDX
00000461: #50 := R13
00000464: RSP := RSP - 8
00000467: mem := mem with [RSP, el]:u64 <- #50
00000470: #51 := R12
00000473: RSP := RSP - 8
00000476: mem := mem with [RSP, el]:u64 <- #51
0000047d: R12 := 0x600E10
00000486: #52 := RBP
00000489: RSP := RSP - 8
0000048c: mem := mem with [RSP, el]:u64 <- #52
00000493: RBP := 0x600E18
0000049c: #53 := RBX
0000049f: RSP := RSP - 8
000004a2: mem := mem with [RSP, el]:u64 <- #53
000004a9: R13 := pad:64[low:32[RDI]]
000004b0: R14 := RSI
000004bf: #54 := RBP
000004c2: #55 := R12
000004c5: RBP := RBP - R12
000004c8: CF := #54 < #55
000004cb: OF := high:1[(#54 ^ #55) & (#54 ^ RBP)]
000004ce: AF := 0x10 = (0x10 & (RBP ^ #54 ^ #55))
000004d1: PF := ~low:1[let $1 = RBP >> 4 ^ RBP in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
000004d4: SF := high:1[RBP]
000004d7: ZF := 0 = RBP
000004e5: #57 := RSP
000004e8: RSP := RSP - 8
000004eb: CF := #57 < 8
000004ee: OF := high:1[(#57 ^ 8) & (#57 ^ RSP)]
000004f1: AF := 0x10 = (0x10 & (RSP ^ #57 ^ 8))
000004f4: PF := ~low:1[let $1 = RSP >> 4 ^ RSP in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
000004f7: SF := high:1[RSP]
000004fa: ZF := 0 = RSP
00000508: #60 := RBP
0000050b: RBP := RBP ~>> 3
0000050e: CF := high:1[#60 << 0x3D]
00000511: SF := high:1[RBP]
00000514: ZF := 0 = RBP
00000517: PF := ~low:1[let $1 = RBP >> 4 ^ RBP in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
0000051a: AF := unknown[bits]:u1
0000051d: OF := unknown[bits]:u1
00000526: RSP := RSP - 8
00000529: mem := mem with [RSP, el]:u64 <- 0x400531
0000052c: call @_init with return %0000052e

0000052e: 
00000539: #62 := RBP
0000053c: OF := 0
0000053f: CF := 0
00000542: AF := unknown[bits]:u1
00000545: PF := ~low:1[let $1 = #62 >> 4 ^ #62 in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
00000548: SF := high:1[#62]
0000054b: ZF := 0 = #62
00000555: when ZF goto %0000054f
000007c4: goto %000005e5

000005e5: 
000005f0: RBX := 0
000005f3: AF := unknown[bits]:u1
000005f6: ZF := 1
000005f9: PF := 1
000005fc: OF := 0
000005ff: CF := 0
00000602: SF := 0
000007c5: goto %00000607

00000607: 
0000060c: RDX := R15
00000613: RSI := R14
0000061a: RDI := pad:64[low:32[R13]]
00000624: #69 := mem[R12 + (RBX << 3), el]:u64
00000627: RSP := RSP - 8
0000062a: mem := mem with [RSP, el]:u64 <- 0x40054D
0000062e: call #69 with return %00000630

00000630: 
0000063c: #70 := RBX
0000063f: RBX := RBX + 1
00000642: CF := RBX < #70
00000645: OF := ~high:1[#70] & (high:1[#70] | high:1[RBX]) & ~(high:1[#70] & high:1[RBX])
00000648: AF := 0x10 = (0x10 & (RBX ^ #70 ^ 1))
0000064b: PF := ~low:1[let $1 = RBX >> 4 ^ RBX in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
0000064e: SF := high:1[RBX]
00000651: ZF := 0 = RBX
0000065e: #73 := RBP - RBX
00000661: CF := RBP < RBX
00000664: OF := high:1[(RBP ^ RBX) & (RBP ^ #73)]
00000667: AF := 0x10 = (0x10 & (#73 ^ RBP ^ RBX))
0000066a: PF := ~low:1[let $1 = #73 >> 4 ^ #73 in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
0000066d: SF := high:1[#73]
00000670: ZF := 0 = #73
00000679: when ~ZF goto %00000607
000007c6: goto %0000054f

0000054f: 
00000566: #64 := RSP
00000569: RSP := RSP + 8
0000056c: CF := RSP < #64
0000056f: OF := ~high:1[#64] & (high:1[#64] | high:1[RSP]) & ~(high:1[#64] & high:1[RSP])
00000572: AF := 0x10 = (0x10 & (RSP ^ #64 ^ 8))
00000575: PF := ~low:1[let $1 = RSP >> 4 ^ RSP in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
00000578: SF := high:1[RSP]
0000057b: ZF := 0 = RSP
00000583: RBX := mem[RSP, el]:u64
00000586: RSP := RSP + 8
0000058e: RBP := mem[RSP, el]:u64
00000591: RSP := RSP + 8
00000599: R12 := mem[RSP, el]:u64
0000059c: RSP := RSP + 8
000005a4: R13 := mem[RSP, el]:u64
000005a7: RSP := RSP + 8
000005af: R14 := mem[RSP, el]:u64
000005b2: RSP := RSP + 8
000005ba: R15 := mem[RSP, el]:u64
000005bd: RSP := RSP + 8
000005c6: #67 := mem[RSP, el]:u64
000005c9: RSP := RSP + 8
000005cd: call #67 with noreturn


000007c7: sub _dl_relocate_static_pie()
0000017e: 
00000185: #17 := mem[RSP, el]:u64
00000188: RSP := RSP + 8
0000018c: call #17 with noreturn


000007c8: sub _fini()
00000769: 
00000775: #81 := RSP
00000778: RSP := RSP - 8
0000077b: CF := #81 < 8
0000077e: OF := high:1[(#81 ^ 8) & (#81 ^ RSP)]
00000781: AF := 0x10 = (0x10 & (RSP ^ #81 ^ 8))
00000784: PF := ~low:1[let $1 = RSP >> 4 ^ RSP in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
00000787: SF := high:1[RSP]
0000078a: ZF := 0 = RSP
00000798: #84 := RSP
0000079b: RSP := RSP + 8
0000079e: CF := RSP < #84
000007a1: OF := ~high:1[#84] & (high:1[#84] | high:1[RSP]) & ~(high:1[#84] & high:1[RSP])
000007a4: AF := 0x10 = (0x10 & (RSP ^ #84 ^ 8))
000007a7: PF := ~low:1[let $1 = RSP >> 4 ^ RSP in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
000007aa: SF := high:1[RSP]
000007ad: ZF := 0 = RSP
000007b6: #87 := mem[RSP, el]:u64
000007b9: RSP := RSP + 8
000007bd: call #87 with noreturn


000007c9: sub _init()
00000008: 
00000014: #1 := RSP
00000018: RSP := RSP - 8
0000001b: CF := #1 < 8
0000001e: OF := high:1[(#1 ^ 8) & (#1 ^ RSP)]
00000021: AF := 0x10 = (0x10 & (RSP ^ #1 ^ 8))
00000024: PF := ~low:1[let $1 = RSP >> 4 ^ RSP in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
00000027: SF := high:1[RSP]
0000002a: ZF := 0 = RSP
00000031: RAX := mem[0x600FF8, el]:u64
0000003e: #4 := RAX
00000041: OF := 0
00000044: CF := 0
00000047: AF := unknown[bits]:u1
0000004a: PF := ~low:1[let $1 = #4 >> 4 ^ #4 in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
0000004d: SF := high:1[#4]
00000050: ZF := 0 = #4
0000005a: when ZF goto %00000054
000007ca: goto %00000092

00000092: 
0000009a: #10 := RAX
0000009d: RSP := RSP - 8
000000a0: mem := mem with [RSP, el]:u64 <- 0x4003BA
000000a4: call #10 with return %00000054

00000054: 
0000006b: #6 := RSP
0000006e: RSP := RSP + 8
00000071: CF := RSP < #6
00000074: OF := ~high:1[#6] & (high:1[#6] | high:1[RSP]) & ~(high:1[#6] & high:1[RSP])
00000077: AF := 0x10 = (0x10 & (RSP ^ #6 ^ 8))
0000007a: PF := ~low:1[let $1 = RSP >> 4 ^ RSP in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
0000007d: SF := high:1[RSP]
00000080: ZF := 0 = RSP
00000089: #9 := mem[RSP, el]:u64
0000008c: RSP := RSP + 8
00000090: call #9 with noreturn


000007cb: sub _start()
000000da: 
000000e5: RBP := 0
000000e8: AF := unknown[bits]:u1
000000eb: ZF := 1
000000ee: PF := 1
000000f1: OF := 0
000000f4: CF := 0
000000f7: SF := 0
000000fe: R9 := RDX
00000106: RSI := mem[RSP, el]:u64
00000109: RSP := RSP + 8
00000110: RDX := RSP
0000011d: RSP := RSP & 0xFFFFFFFFFFFFFFF0
00000120: OF := 0
00000123: CF := 0
00000126: AF := unknown[bits]:u1
00000129: PF := ~low:1[let $1 = RSP >> 4 ^ RSP in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
0000012c: SF := high:1[RSP]
0000012f: ZF := 0 = RSP
00000138: #14 := RAX
0000013b: RSP := RSP - 8
0000013e: mem := mem with [RSP, el]:u64 <- #14
00000147: #15 := RSP
0000014a: RSP := RSP - 8
0000014d: mem := mem with [RSP, el]:u64 <- #15
00000154: R8 := 0x400570
0000015b: RCX := 0x400500
00000162: RDI := 0x4004D0
0000016c: #16 := mem[0x600FF0, el]:u64
0000016f: RSP := RSP - 8
00000172: mem := mem with [RSP, el]:u64 <- 0x40040A
00000176: call #16 with return %00000178

00000178: 
000007cc: call @_dl_relocate_static_pie with noreturn


000007cd: sub deregister_tm_clones()
00000194: 
0000019b: #18 := RBP
0000019e: RSP := RSP - 8
000001a1: mem := mem with [RSP, el]:u64 <- #18
000001a8: RAX := 0x601030
000001b5: #19 := RAX - 0x601030
000001b8: CF := RAX < 0x601030
000001bb: OF := high:1[(RAX ^ 0x601030) & (RAX ^ #19)]
000001be: AF := 0x10 = (0x10 & (#19 ^ RAX ^ 0x601030))
000001c1: PF := ~low:1[let $1 = #19 >> 4 ^ #19 in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
000001c4: SF := high:1[#19]
000001c7: ZF := 0 = #19
000001ce: RBP := RSP
000001d8: when ZF goto %000001d2
000007ce: goto %00000719

00000719: 
0000071e: RAX := 0
0000072b: #79 := RAX
0000072e: OF := 0
00000731: CF := 0
00000734: AF := unknown[bits]:u1
00000737: PF := ~low:1[let $1 = #79 >> 4 ^ #79 in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
0000073a: SF := high:1[#79]
0000073d: ZF := 0 = #79
00000746: when ZF goto %000001d2
000007cf: goto %0000074c

000001d2: 
000001e3: RBP := mem[RSP, el]:u64
000001e6: RSP := RSP + 8
000001ef: #21 := mem[RSP, el]:u64
000001f2: RSP := RSP + 8
000001f6: call #21 with noreturn

0000074c: 
00000752: RBP := mem[RSP, el]:u64
00000755: RSP := RSP + 8
0000075c: RDI := 0x601030
00000764: call RAX with noreturn


000007d0: sub frame_dummy()
0000033f: 
00000346: #39 := RBP
00000349: RSP := RSP - 8
0000034c: mem := mem with [RSP, el]:u64 <- #39
00000353: RBP := RSP
0000035b: RBP := mem[RSP, el]:u64
0000035e: RSP := RSP + 8
00000365: call @register_tm_clones with noreturn


000007d1: sub main()
0000036a: 
00000371: #40 := RBP
00000374: RSP := RSP - 8
00000377: mem := mem with [RSP, el]:u64 <- #40
0000037e: RBP := RSP
0000038c: #41 := RSP
0000038f: RSP := RSP - 0x10
00000392: CF := #41 < 0x10
00000395: OF := high:1[(#41 ^ 0x10) & (#41 ^ RSP)]
00000398: AF := 0x10 = (0x10 & (RSP ^ #41 ^ 0x10))
0000039b: PF := ~low:1[let $1 = RSP >> 4 ^ RSP in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
0000039e: SF := high:1[RSP]
000003a1: ZF := 0 = RSP
000003a8: RDI := 0x400584
000003af: mem := mem with [RBP - 4, el]:u32 <- 0
000003b6: RAX := high:56[RAX].0
000003bf: RSP := RSP - 8
000003c2: mem := mem with [RSP, el]:u64 <- 0x4004F0
000003c5: call @printf with return %000003c7

000003c7: 
000003d2: RCX := 0
000003d5: AF := unknown[bits]:u1
000003d8: ZF := 1
000003db: PF := 1
000003de: OF := 0
000003e1: CF := 0
000003e4: SF := 0
000003eb: mem := mem with [RBP - 8, el]:u32 <- low:32[RAX]
000003f2: RAX := pad:64[low:32[RCX]]
00000400: #44 := RSP
00000403: RSP := RSP + 0x10
00000406: CF := RSP < #44
00000409: OF := ~high:1[#44] & (high:1[#44] | high:1[RSP]) & ~(high:1[#44] & high:1[RSP])
0000040c: AF := 0x10 = (0x10 & (RSP ^ #44 ^ 0x10))
0000040f: PF := ~low:1[let $1 = RSP >> 4 ^ RSP in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
00000412: SF := high:1[RSP]
00000415: ZF := 0 = RSP
0000041d: RBP := mem[RSP, el]:u64
00000420: RSP := RSP + 8
00000429: #47 := mem[RSP, el]:u64
0000042c: RSP := RSP + 8
00000430: call #47 with noreturn


000007d2: sub printf()
000000c0: 
000000c6: call mem[0x601018, el]:u64 with noreturn


000007d3: sub register_tm_clones()
000001fb: 
00000200: RSI := 0x601030
00000209: #22 := RBP
0000020c: RSP := RSP - 8
0000020f: mem := mem with [RSP, el]:u64 <- #22
0000021d: #23 := RSI
00000220: RSI := RSI - 0x601030
00000223: CF := #23 < 0x601030
00000226: OF := high:1[(#23 ^ 0x601030) & (#23 ^ RSI)]
00000229: AF := 0x10 = (0x10 & (RSI ^ #23 ^ 0x601030))
0000022c: PF := ~low:1[let $1 = RSI >> 4 ^ RSI in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
0000022f: SF := high:1[RSI]
00000232: ZF := 0 = RSI
00000239: RBP := RSP
00000247: #26 := RSI
0000024a: RSI := RSI ~>> 3
0000024d: CF := high:1[#26 << 0x3D]
00000250: SF := high:1[RSI]
00000253: ZF := 0 = RSI
00000256: PF := ~low:1[let $1 = RSI >> 4 ^ RSI in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
00000259: AF := unknown[bits]:u1
0000025c: OF := unknown[bits]:u1
00000263: RAX := RSI
00000271: #28 := RAX
00000274: RAX := RAX >> 0x3F
00000277: CF := high:1[#28 << 1]
0000027a: SF := high:1[RAX]
0000027d: ZF := 0 = RAX
00000280: PF := ~low:1[let $1 = RAX >> 4 ^ RAX in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
00000283: AF := unknown[bits]:u1
00000286: OF := unknown[bits]:u1
00000295: #30 := RSI
00000298: #31 := RAX
0000029b: RSI := RSI + #31
0000029e: CF := RSI < #30
000002a1: OF := high:1[#30] = high:1[#31] & (high:1[#30] | high:1[RSI]) & ~(
high:1[#30] & high:1[RSI])
000002a4: AF := 0x10 = (0x10 & (RSI ^ #30 ^ #31))
000002a7: PF := ~low:1[let $1 = RSI >> 4 ^ RSI in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
000002aa: SF := high:1[RSI]
000002ad: ZF := 0 = RSI
000002bb: #33 := RSI
000002be: RSI := RSI ~>> 1
000002c1: CF := high:1[#33 << 0x3F]
000002c4: SF := high:1[RSI]
000002c7: ZF := 0 = RSI
000002ca: PF := ~low:1[let $1 = RSI >> 4 ^ RSI in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
000002cd: AF := unknown[bits]:u1
000002d0: OF := 0
000002da: when ZF goto %000002d4
000007d4: goto %000006c9

000006c9: 
000006ce: RAX := 0
000006db: #77 := RAX
000006de: OF := 0
000006e1: CF := 0
000006e4: AF := unknown[bits]:u1
000006e7: PF := ~low:1[let $1 = #77 >> 4 ^ #77 in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
000006ea: SF := high:1[#77]
000006ed: ZF := 0 = #77
000006f6: when ZF goto %000002d4
000007d5: goto %000006fc

000002d4: 
000002e5: RBP := mem[RSP, el]:u64
000002e8: RSP := RSP + 8
000002f1: #35 := mem[RSP, el]:u64
000002f4: RSP := RSP + 8
000002f8: call #35 with noreturn

000006fc: 
00000702: RBP := mem[RSP, el]:u64
00000705: RSP := RSP + 8
0000070c: RDI := 0x601030
00000714: call RAX with noreturn
```
*)

let mem = Project.memory proj;;
(*
```
val mem : value memmap =
  {[0x400000 - 0x4006C7] => 02 0x400000 1736, [0x400238 - 0x400253] => .interp, [0x400254 - 0x400273] => .note.ABI-tag, [0x400278 - 0x400293] => .gnu.hash, [0x400298 - 0x4002F7] => .dynsym, [0x4002F8 - 0x400336] => .dynstr, [0x400338 - 0x40033F] => .gnu.version, [0x400340 - 0x40035F] => .gnu.version_r, [0x400360 - 0x40038F] => .rela.dyn, [0x400390 - 0x4003A7] => .rela.plt, [0x4003A8 - 0x4003BE] => (), [0x4003C0 - 0x4003DF] => (), [0x4003E0 - 0x400571] => (), [0x400574 - 0x40057C] => (), [0x4003A8 - 0x4003BE] => .init, [0x4003C0 - 0x4003DF] => .plt, [0x4003E0 - 0x40040A] => _start, [0x4003E0 - 0x40040A] => _start 0x4003E0 43, [0x400410 - 0x400411] => _dl_relocate_static_pie, [0x400410 - 0x400411] => _dl_relocate_static_pie 0x400410 2, [0x4003E0 - 0x400571] => .text, [0x4004D0 - 0x4004FC] => main, [0x4004D0 - 0x4004FC] => main 0x4004D0 45, [0x400500 - 0x400564] => __libc_csu_init, [0x400500 - 0x400564] => __libc_csu_init 0x400500 101, [0x400570 - 0x400571] => __libc_csu_fini, [0x400570 - 0x400571] => __libc_csu_fini 0x400570 2, [0x400574 - 0x40057C] => .fini, [0x400580 - 0x400587] => .rodata, [0x400588 - 0x4005C3] => .eh_frame_hdr, [0x4005C8 - 0x4006C7] => .eh_frame, [0x600E10 - 0x60102F] => 03 0x600E10 552, [0x600E10 - 0x600E17] => .init_array, [0x600E18 - 0x600E1F] => .fini_array, [0x600E20 - 0x600FEF] => .dynamic, [0x600FF0 - 0x600FFF] => .got, [0x601000 - 0x60101F] => .got.plt, [0x601020 - 0x60102F] => .data}
```
*)

let subs = Term.enum sub_t prog;;

(*
```
val subs : sub term seq = {000007bf: sub .plt()
000000a6: 
000000ad: #11 := mem[0x601008, el]:u64
000000b0: RSP := RSP - 8
000000b3: mem := mem with [RSP, el]:u64 <- #11
000000bb: call mem[0x601010, el]:u64 with noreturn


, 000007c0: sub __do_global_dtors_aux()
000002fd: 
00000308: #36 := mem[0x601030]
0000030b: CF := mem[0x601030] < 0
0000030e: OF := high:1[mem[0x601030] & (mem[0x601030] ^ #36)]
00000311: AF := 0x10 = (0x10 & (#36 ^ mem[0x601030]))
00000314: PF := ~low:1[let $1 = #36 >> 4 ^ #36 in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
00000317: SF := high:1[#36]
0000031a: ZF := 0 = #36
00000324: when ~ZF goto %0000031e
000007c1: goto %0000067f

0000031e: 
00000330: #38 := mem[RSP, el]:u64
00000333: RSP := RSP + 8
00000337: call #38 with noreturn

0000067f: 
00000686: #75 := RBP
00000689: RSP := RSP - 8
0000068c: mem := mem with [RSP, el]:u64 <- #75
00000693: RBP := RSP
0000069c: RSP := RSP - 8
0000069f: mem := mem with [RSP, el]:u64 <- 0x4004A2
000006a2: call @deregister_tm_clones with return %000006a4

000006a4: 
000006a9: mem := mem with [0x601030] <- 1
000006b1: RBP := mem[RSP, el]:u64
000006b4: RSP := RSP + 8
000006bd: #76 := mem[RSP, el]:u64
000006c0: RSP := RSP + 8
000006c4: call #76 with noreturn


, 000007c2: sub __libc_csu_fini()
000005d5: 
000005dc: #68 := mem[RSP, el]:u64
000005df: RSP := RSP + 8
000005e3: call #68 with noreturn


, 000007c3: sub __libc_csu_init()
00000435: 
0000043c: #48 := R15
0000043f: RSP := RSP - 8
00000442: mem := mem with [RSP, el]:u64 <- #48
0000044b: #49 := R14
0000044e: RSP := RSP - 8
00000451: mem := mem with [RSP, el]:u64 <- #49
00000458: R15 := RDX
00000461: #50 := R13
00000464: RSP := RSP - 8
00000467: mem := mem with [RSP, el]:u64 <- #50
00000470: #51 := R12
00000473: RSP := RSP - 8
00000476: mem := mem with [RSP, el]:u64 <- #51
0000047d: R12 := 0x600E10
00000486: #52 := RBP
00000489: RSP := RSP - 8
0000048c: mem := mem with [RSP, el]:u64 <- #52
00000493: RBP := 0x600E18
0000049c: #53 := RBX
0000049f: RSP := RSP - 8
000004a2: mem := mem with [RSP, el]:u64 <- #53
000004a9: R13 := pad:64[low:32[RDI]]
000004b0: R14 := RSI
000004bf: #54 := RBP
000004c2: #55 := R12
000004c5: RBP := RBP - R12
000004c8: CF := #54 < #55
000004cb: OF := high:1[(#54 ^ #55) & (#54 ^ RBP)]
000004ce: AF := 0x10 = (0x10 & (RBP ^ #54 ^ #55))
000004d1: PF := ~low:1[let $1 = RBP >> 4 ^ RBP in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
000004d4: SF := high:1[RBP]
000004d7: ZF := 0 = RBP
000004e5: #57 := RSP
000004e8: RSP := RSP - 8
000004eb: CF := #57 < 8
000004ee: OF := high:1[(#57 ^ 8) & (#57 ^ RSP)]
000004f1: AF := 0x10 = (0x10 & (RSP ^ #57 ^ 8))
000004f4: PF := ~low:1[let $1 = RSP >> 4 ^ RSP in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
000004f7: SF := high:1[RSP]
000004fa: ZF := 0 = RSP
00000508: #60 := RBP
0000050b: RBP := RBP ~>> 3
0000050e: CF := high:1[#60 << 0x3D]
00000511: SF := high:1[RBP]
00000514: ZF := 0 = RBP
00000517: PF := ~low:1[let $1 = RBP >> 4 ^ RBP in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
0000051a: AF := unknown[bits]:u1
0000051d: OF := unknown[bits]:u1
00000526: RSP := RSP - 8
00000529: mem := mem with [RSP, el]:u64 <- 0x400531
0000052c: call @_init with return %0000052e

0000052e: 
00000539: #62 := RBP
0000053c: OF := 0
0000053f: CF := 0
00000542: AF := unknown[bits]:u1
00000545: PF := ~low:1[let $1 = #62 >> 4 ^ #62 in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
00000548: SF := high:1[#62]
0000054b: ZF := 0 = #62
00000555: when ZF goto %0000054f
000007c4: goto %000005e5

000005e5: 
000005f0: RBX := 0
000005f3: AF := unknown[bits]:u1
000005f6: ZF := 1
000005f9: PF := 1
000005fc: OF := 0
000005ff: CF := 0
00000602: SF := 0
000007c5: goto %00000607

00000607: 
0000060c: RDX := R15
00000613: RSI := R14
0000061a: RDI := pad:64[low:32[R13]]
00000624: #69 := mem[R12 + (RBX << 3), el]:u64
00000627: RSP := RSP - 8
0000062a: mem := mem with [RSP, el]:u64 <- 0x40054D
0000062e: call #69 with return %00000630

00000630: 
0000063c: #70 := RBX
0000063f: RBX := RBX + 1
00000642: CF := RBX < #70
00000645: OF := ~high:1[#70] & (high:1[#70] | high:1[RBX]) & ~(high:1[#70] & high:1[RBX])
00000648: AF := 0x10 = (0x10 & (RBX ^ #70 ^ 1))
0000064b: PF := ~low:1[let $1 = RBX >> 4 ^ RBX in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
0000064e: SF := high:1[RBX]
00000651: ZF := 0 = RBX
0000065e: #73 := RBP - RBX
00000661: CF := RBP < RBX
00000664: OF := high:1[(RBP ^ RBX) & (RBP ^ #73)]
00000667: AF := 0x10 = (0x10 & (#73 ^ RBP ^ RBX))
0000066a: PF := ~low:1[let $1 = #73 >> 4 ^ #73 in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
0000066d: SF := high:1[#73]
00000670: ZF := 0 = #73
00000679: when ~ZF goto %00000607
000007c6: goto %0000054f

0000054f: 
00000566: #64 := RSP
00000569: RSP := RSP + 8
0000056c: CF := RSP < #64
0000056f: OF := ~high:1[#64] & (high:1[#64] | high:1[RSP]) & ~(high:1[#64] & high:1[RSP])
00000572: AF := 0x10 = (0x10 & (RSP ^ #64 ^ 8))
00000575: PF := ~low:1[let $1 = RSP >> 4 ^ RSP in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
00000578: SF := high:1[RSP]
0000057b: ZF := 0 = RSP
00000583: RBX := mem[RSP, el]:u64
00000586: RSP := RSP + 8
0000058e: RBP := mem[RSP, el]:u64
00000591: RSP := RSP + 8
00000599: R12 := mem[RSP, el]:u64
0000059c: RSP := RSP + 8
000005a4: R13 := mem[RSP, el]:u64
000005a7: RSP := RSP + 8
000005af: R14 := mem[RSP, el]:u64
000005b2: RSP := RSP + 8
000005ba: R15 := mem[RSP, el]:u64
000005bd: RSP := RSP + 8
000005c6: #67 := mem[RSP, el]:u64
000005c9: RSP := RSP + 8
000005cd: call #67 with noreturn


, 000007c7: sub _dl_relocate_static_pie()
0000017e: 
00000185: #17 := mem[RSP, el]:u64
00000188: RSP := RSP + 8
0000018c: call #17 with noreturn


, 000007c8: sub _fini()
00000769: 
00000775: #81 := RSP
00000778: RSP := RSP - 8
0000077b: CF := #81 < 8
0000077e: OF := high:1[(#81 ^ 8) & (#81 ^ RSP)]
00000781: AF := 0x10 = (0x10 & (RSP ^ #81 ^ 8))
00000784: PF := ~low:1[let $1 = RSP >> 4 ^ RSP in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
00000787: SF := high:1[RSP]
0000078a: ZF := 0 = RSP
00000798: #84 := RSP
0000079b: RSP := RSP + 8
0000079e: CF := RSP < #84
000007a1: OF := ~high:1[#84] & (high:1[#84] | high:1[RSP]) & ~(high:1[#84] & high:1[RSP])
000007a4: AF := 0x10 = (0x10 & (RSP ^ #84 ^ 8))
000007a7: PF := ~low:1[let $1 = RSP >> 4 ^ RSP in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
000007aa: SF := high:1[RSP]
000007ad: ZF := 0 = RSP
000007b6: #87 := mem[RSP, el]:u64
000007b9: RSP := RSP + 8
000007bd: call #87 with noreturn


, 000007c9: sub _init()
00000008: 
00000014: #1 := RSP
00000018: RSP := RSP - 8
0000001b: CF := #1 < 8
0000001e: OF := high:1[(#1 ^ 8) & (#1 ^ RSP)]
00000021: AF := 0x10 = (0x10 & (RSP ^ #1 ^ 8))
00000024: PF := ~low:1[let $1 = RSP >> 4 ^ RSP in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
00000027: SF := high:1[RSP]
0000002a: ZF := 0 = RSP
00000031: RAX := mem[0x600FF8, el]:u64
0000003e: #4 := RAX
00000041: OF := 0
00000044: CF := 0
00000047: AF := unknown[bits]:u1
0000004a: PF := ~low:1[let $1 = #4 >> 4 ^ #4 in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
0000004d: SF := high:1[#4]
00000050: ZF := 0 = #4
0000005a: when ZF goto %00000054
000007ca: goto %00000092

00000092: 
0000009a: #10 := RAX
0000009d: RSP := RSP - 8
000000a0: mem := mem with [RSP, el]:u64 <- 0x4003BA
000000a4: call #10 with return %00000054

00000054: 
0000006b: #6 := RSP
0000006e: RSP := RSP + 8
00000071: CF := RSP < #6
00000074: OF := ~high:1[#6] & (high:1[#6] | high:1[RSP]) & ~(high:1[#6] & high:1[RSP])
00000077: AF := 0x10 = (0x10 & (RSP ^ #6 ^ 8))
0000007a: PF := ~low:1[let $1 = RSP >> 4 ^ RSP in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
0000007d: SF := high:1[RSP]
00000080: ZF := 0 = RSP
00000089: #9 := mem[RSP, el]:u64
0000008c: RSP := RSP + 8
00000090: call #9 with noreturn


, 000007cb: sub _start()
000000da: 
000000e5: RBP := 0
000000e8: AF := unknown[bits]:u1
000000eb: ZF := 1
000000ee: PF := 1
000000f1: OF := 0
000000f4: CF := 0
000000f7: SF := 0
000000fe: R9 := RDX
00000106: RSI := mem[RSP, el]:u64
00000109: RSP := RSP + 8
00000110: RDX := RSP
0000011d: RSP := RSP & 0xFFFFFFFFFFFFFFF0
00000120: OF := 0
00000123: CF := 0
00000126: AF := unknown[bits]:u1
00000129: PF := ~low:1[let $1 = RSP >> 4 ^ RSP in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
0000012c: SF := high:1[RSP]
0000012f: ZF := 0 = RSP
00000138: #14 := RAX
0000013b: RSP := RSP - 8
0000013e: mem := mem with [RSP, el]:u64 <- #14
00000147: #15 := RSP
0000014a: RSP := RSP - 8
0000014d: mem := mem with [RSP, el]:u64 <- #15
00000154: R8 := 0x400570
0000015b: RCX := 0x400500
00000162: RDI := 0x4004D0
0000016c: #16 := mem[0x600FF0, el]:u64
0000016f: RSP := RSP - 8
00000172: mem := mem with [RSP, el]:u64 <- 0x40040A
00000176: call #16 with return %00000178

00000178: 
000007cc: call @_dl_relocate_static_pie with noreturn


, 000007cd: sub deregister_tm_clones()
00000194: 
0000019b: #18 := RBP
0000019e: RSP := RSP - 8
000001a1: mem := mem with [RSP, el]:u64 <- #18
000001a8: RAX := 0x601030
000001b5: #19 := RAX - 0x601030
000001b8: CF := RAX < 0x601030
000001bb: OF := high:1[(RAX ^ 0x601030) & (RAX ^ #19)]
000001be: AF := 0x10 = (0x10 & (#19 ^ RAX ^ 0x601030))
000001c1: PF := ~low:1[let $1 = #19 >> 4 ^ #19 in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
000001c4: SF := high:1[#19]
000001c7: ZF := 0 = #19
000001ce: RBP := RSP
000001d8: when ZF goto %000001d2
000007ce: goto %00000719

00000719: 
0000071e: RAX := 0
0000072b: #79 := RAX
0000072e: OF := 0
00000731: CF := 0
00000734: AF := unknown[bits]:u1
00000737: PF := ~low:1[let $1 = #79 >> 4 ^ #79 in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
0000073a: SF := high:1[#79]
0000073d: ZF := 0 = #79
00000746: when ZF goto %000001d2
000007cf: goto %0000074c

000001d2: 
000001e3: RBP := mem[RSP, el]:u64
000001e6: RSP := RSP + 8
000001ef: #21 := mem[RSP, el]:u64
000001f2: RSP := RSP + 8
000001f6: call #21 with noreturn

0000074c: 
00000752: RBP := mem[RSP, el]:u64
00000755: RSP := RSP + 8
0000075c: RDI := 0x601030
00000764: call RAX with noreturn


, 000007d0: sub frame_dummy()
0000033f: 
00000346: #39 := RBP
00000349: RSP := RSP - 8
0000034c: mem := mem with [RSP, el]:u64 <- #39
00000353: RBP := RSP
0000035b: RBP := mem[RSP, el]:u64
0000035e: RSP := RSP + 8
00000365: call @register_tm_clones with noreturn


, 000007d1: sub main()
0000036a: 
00000371: #40 := RBP
00000374: RSP := RSP - 8
00000377: mem := mem with [RSP, el]:u64 <- #40
0000037e: RBP := RSP
0000038c: #41 := RSP
0000038f: RSP := RSP - 0x10
00000392: CF := #41 < 0x10
00000395: OF := high:1[(#41 ^ 0x10) & (#41 ^ RSP)]
00000398: AF := 0x10 = (0x10 & (RSP ^ #41 ^ 0x10))
0000039b: PF := ~low:1[let $1 = RSP >> 4 ^ RSP in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
0000039e: SF := high:1[RSP]
000003a1: ZF := 0 = RSP
000003a8: RDI := 0x400584
000003af: mem := mem with [RBP - 4, el]:u32 <- 0
000003b6: RAX := high:56[RAX].0
000003bf: RSP := RSP - 8
000003c2: mem := mem with [RSP, el]:u64 <- 0x4004F0
000003c5: call @printf with return %000003c7

000003c7: 
000003d2: RCX := 0
000003d5: AF := unknown[bits]:u1
000003d8: ZF := 1
000003db: PF := 1
000003de: OF := 0
000003e1: CF := 0
000003e4: SF := 0
000003eb: mem := mem with [RBP - 8, el]:u32 <- low:32[RAX]
000003f2: RAX := pad:64[low:32[RCX]]
00000400: #44 := RSP
00000403: RSP := RSP + 0x10
00000406: CF := RSP < #44
00000409: OF := ~high:1[#44] & (high:1[#44] | high:1[RSP]) & ~(high:1[#44] & high:1[RSP])
0000040c: AF := 0x10 = (0x10 & (RSP ^ #44 ^ 0x10))
0000040f: PF := ~low:1[let $1 = RSP >> 4 ^ RSP in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
00000412: SF := high:1[RSP]
00000415: ZF := 0 = RSP
0000041d: RBP := mem[RSP, el]:u64
00000420: RSP := RSP + 8
00000429: #47 := mem[RSP, el]:u64
0000042c: RSP := RSP + 8
00000430: call #47 with noreturn


, 000007d2: sub printf()
000000c0: 
000000c6: call mem[0x601018, el]:u64 with noreturn


, 000007d3: sub register_tm_clones()
000001fb: 
00000200: RSI := 0x601030
00000209: #22 := RBP
0000020c: RSP := RSP - 8
0000020f: mem := mem with [RSP, el]:u64 <- #22
0000021d: #23 := RSI
00000220: RSI := RSI - 0x601030
00000223: CF := #23 < 0x601030
00000226: OF := high:1[(#23 ^ 0x601030) & (#23 ^ RSI)]
00000229: AF := 0x10 = (0x10 & (RSI ^ #23 ^ 0x601030))
0000022c: PF := ~low:1[let $1 = RSI >> 4 ^ RSI in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
0000022f: SF := high:1[RSI]
00000232: ZF := 0 = RSI
00000239: RBP := RSP
00000247: #26 := RSI
0000024a: RSI := RSI ~>> 3
0000024d: CF := high:1[#26 << 0x3D]
00000250: SF := high:1[RSI]
00000253: ZF := 0 = RSI
00000256: PF := ~low:1[let $1 = RSI >> 4 ^ RSI in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
00000259: AF := unknown[bits]:u1
0000025c: OF := unknown[bits]:u1
00000263: RAX := RSI
00000271: #28 := RAX
00000274: RAX := RAX >> 0x3F
00000277: CF := high:1[#28 << 1]
0000027a: SF := high:1[RAX]
0000027d: ZF := 0 = RAX
00000280: PF := ~low:1[let $1 = RAX >> 4 ^ RAX in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
00000283: AF := unknown[bits]:u1
00000286: OF := unknown[bits]:u1
00000295: #30 := RSI
00000298: #31 := RAX
0000029b: RSI := RSI + #31
0000029e: CF := RSI < #30
000002a1: OF := high:1[#30] = high:1[#31] & (high:1[#30] | high:1[RSI]) & ~(
high:1[#30] & high:1[RSI])
000002a4: AF := 0x10 = (0x10 & (RSI ^ #30 ^ #31))
000002a7: PF := ~low:1[let $1 = RSI >> 4 ^ RSI in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
000002aa: SF := high:1[RSI]
000002ad: ZF := 0 = RSI
000002bb: #33 := RSI
000002be: RSI := RSI ~>> 1
000002c1: CF := high:1[#33 << 0x3F]
000002c4: SF := high:1[RSI]
000002c7: ZF := 0 = RSI
000002ca: PF := ~low:1[let $1 = RSI >> 4 ^ RSI in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
000002cd: AF := unknown[bits]:u1
000002d0: OF := 0
000002da: when ZF goto %000002d4
000007d4: goto %000006c9

000006c9: 
000006ce: RAX := 0
000006db: #77 := RAX
000006de: OF := 0
000006e1: CF := 0
000006e4: AF := unknown[bits]:u1
000006e7: PF := ~low:1[let $1 = #77 >> 4 ^ #77 in let $2 = $1 >> 2 ^ $1 in
$2 >> 1 ^ $2]
000006ea: SF := high:1[#77]
000006ed: ZF := 0 = #77
000006f6: when ZF goto %000002d4
000007d5: goto %000006fc

000002d4: 
000002e5: RBP := mem[RSP, el]:u64
000002e8: RSP := RSP + 8
000002f1: #35 := mem[RSP, el]:u64
000002f4: RSP := RSP + 8
000002f8: call #35 with noreturn

000006fc: 
00000702: RBP := mem[RSP, el]:u64
00000705: RSP := RSP + 8
0000070c: RDI := 0x601030
00000714: call RAX with noreturn


}
```
*)

(*
let find_section_by_name name =
    let memory = Project.memory file_input_proj in
    Memmap.to_sequence memory |> Seq.find_map ~f:(fun (m,x) ->
        Option.(Value.get Image.section x >>= fun n ->
                Option.some_if (n = name) m)) in
  (match find_section_by_name ".rodata" with
   | Some mem -> Format.printf "\n%a\n" Memory.pp mem
   | None -> Format.printf "No memory for this section\n")
;;
*)
let find_section_by_name name fproj =
    let memory = Project.memory fproj in
    Memmap.to_sequence memory |> Seq.find_map ~f:(fun (m,x) ->
        Option.(Value.get Image.section x >>= fun n ->
                Option.some_if (n = name) m)) 



let section = find_section_by_name ".rodata" proj;;

(* `val section : mem option = Some 400580: 01 00 02 00 66 6f 6f 00` *)
let section = find_section_by_name ".bss" proj;;

(* `val section : mem option = None` *)

let section = find_section_by_name ".text" proj;;

(* ```val section : mem option =
  Some
004003E0  31 ED 49 89 D1 5E 48 89 E2 48 83 E4 F0 50 54 49 |1.I..^H..H...PTI|
004003F0  C7 C0 70 05 40 00 48 C7 C1 00 05 40 00 48 C7 C7 |..p.@.H....@.H..|
00400400  D0 04 40 00 FF 15 E6 0B 20 00 F4 0F 1F 44 00 00 |..@..... ....D..|
00400410  F3 C3 66 2E 0F 1F 84 00 00 00 00 00 0F 1F 40 00 |..f...........@.|
00400420  55 B8 30 10 60 00 48 3D 30 10 60 00 48 89 E5 74 |U.0.`.H=0.`.H..t|
00400430  17 B8 00 00 00 00 48 85 C0 74 0D 5D BF 30 10 60 |......H..t.].0.`|
00400440  00 FF E0 0F 1F 44 00 00 5D C3 66 0F 1F 44 00 00 |.....D..].f..D..|
00400450  BE 30 10 60 00 55 48 81 EE 30 10 60 00 48 89 E5 |.0.`.UH..0.`.H..|
00400460  48 C1 FE 03 48 89 F0 48 C1 E8 3F 48 01 C6 48 D1 |H...H..H..?H..H.|
00400470  FE 74 15 B8 00 00 00 00 48 85 C0 74 0B 5D BF 30 |.t......H..t.].0|
00400480  10 60 00 FF E0 0F 1F 00 5D C3 66 0F 1F 44 00 00 |.`......].f..D..|
00400490  80 3D 99 0B 20 00 00 75 17 55 48 89 E5 E8 7E FF |.=.. ..u.UH...~.|
004004A0  FF FF C6 05 87 0B 20 00 01 5D C3 0F 1F 44 00 00 |...... ..]...D..|
004004B0  F3 C3 0F 1F 40 00 66 2E 0F 1F 84 00 00 00 00 00 |....@.f.........|
004004C0  55 48 89 E5 5D EB 89 66 0F 1F 84 00 00 00 00 00 |UH..]..f........|
004004D0  55 48 89 E5 48 83 EC 10 48 BF 84 05 40 00 00 00 |UH..H...H...@...|
004004E0  00 00 C7 45 FC 00 00 00 00 B0 00 E8 E0 FE FF FF |...E............|
004004F0  31 C9 89 45 F8 89 C8 48 83 C4 10 5D C3 0F 1F 00 |1..E...H...]....|
00400500  41 57 41 56 49 89 D7 41 55 41 54 4C 8D 25 FE 08 |AWAVI..AUATL.%..|
00400510  20 00 55 48 8D 2D FE 08 20 00 53 41 89 FD 49 89 | .UH.-.. .SA..I.|
00400520  F6 4C 29 E5 48 83 EC 08 48 C1 FD 03 E8 77 FE FF |.L).H...H....w..|
00400530  FF 48 85 ED 74 20 31 DB 0F 1F 84 00 00 00 00 00 |.H..t 1.........|
00400540  4C 89 FA 4C 89 F6 44 89 EF 41 FF 14 DC 48 83 C3 |L..L..D..A...H..|
00400550  01 48 39 DD 75 EA 48 83 C4 08 5B 5D 41 5C 41 5D |.H9.u.H...[]A\A]|
00400560  41 5E 41 5F C3 90 66 2E 0F 1F 84 00 00 00 00 00 |A^A_..f.........|
00400570  F3 C3                                           |..              |
``` *)
;;
