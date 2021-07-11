
Disassembly of section .init

401000: <_init>
401000:
401000: f3 0f 1e fa                               endbr64
401004:
401004: 48 83 ec 08                               subq $0x8, %rsp
401008: 48 8b 05 e9 2f 00 00                      movq 0x2fe9(%rip), %rax
40100f: 48 85 c0                                  testq %rax, %rax
401012: 74 02                                     je 0x2
401014:
401014: ff d0                                     callq *%rax
401016:
401016: 48 83 c4 08                               addq $0x8, %rsp
40101a: c3                                        retq

Disassembly of section .plt

401020: <.plt>
401020:
401020: ff 35 e2 2f 00 00                         pushq 0x2fe2(%rip)
401026: ff 25 e4 2f 00 00                         jmpq *0x2fe4(%rip)

401030: <putchar>
401030:
401030: ff 25 e2 2f 00 00                         jmpq *0x2fe2(%rip)
401036:
401036: 68 00 00 00 00                            pushq $0x0
40103b: e9 e0 ff ff ff                            jmp -0x20

401040: <printf>
401040:
401040: ff 25 da 2f 00 00                         jmpq *0x2fda(%rip)
401046:
401046: 68 01 00 00 00                            pushq $0x1
40104b: e9 d0 ff ff ff                            jmp -0x30

401050: <memset>
401050:
401050: ff 25 d2 2f 00 00                         jmpq *0x2fd2(%rip)
401056:
401056: 68 02 00 00 00                            pushq $0x2
40105b: e9 c0 ff ff ff                            jmp -0x40

401060: <memcpy>
401060:
401060: ff 25 ca 2f 00 00                         jmpq *0x2fca(%rip)
401066:
401066: 68 03 00 00 00                            pushq $0x3
40106b: e9 b0 ff ff ff                            jmp -0x50

Disassembly of section .text

401070: <_start>
401070:
401070: f3 0f 1e fa                               endbr64
401074:
401074: 31 ed                                     xorl %ebp, %ebp
401076: 49 89 d1                                  movq %rdx, %r9
401079: 5e                                        popq %rsi
40107a: 48 89 e2                                  movq %rsp, %rdx
40107d: 48 83 e4 f0                               andq $-0x10, %rsp
401081: 50                                        pushq %rax
401082: 54                                        pushq %rsp
401083: 49 c7 c0 10 14 40 00                      movq $0x401410, %r8
40108a: 48 c7 c1 a0 13 40 00                      movq $0x4013a0, %rcx
401091: 48 c7 c7 60 11 40 00                      movq $0x401160, %rdi
401098: ff 15 52 2f 00 00                         callq *0x2f52(%rip)
40109e:
40109e: f4                                        #undefined
40109f: 90                                        #undefined

4010a0: <_dl_relocate_static_pie>
4010a0:
4010a0: f3 0f 1e fa                               endbr64
4010a4:
4010a4: c3                                        retq

4010b0: <deregister_tm_clones>
4010b0:
4010b0: b8 48 40 40 00                            movl $0x404048, %eax
4010b5: 48 3d 48 40 40 00                         cmpq $0x404048, %rax
4010bb: 74 13                                     je 0x13
4010bd:
4010bd: b8 00 00 00 00                            movl $0x0, %eax
4010c2: 48 85 c0                                  testq %rax, %rax
4010c5: 74 09                                     je 0x9
4010c7:
4010c7: bf 48 40 40 00                            movl $0x404048, %edi
4010cc: ff e0                                     jmpq *%rax
4010d0:
4010d0: c3                                        retq

4010e0: <register_tm_clones>
4010e0:
4010e0: be 48 40 40 00                            movl $0x404048, %esi
4010e5: 48 81 ee 48 40 40 00                      subq $0x404048, %rsi
4010ec: 48 89 f0                                  movq %rsi, %rax
4010ef: 48 c1 ee 3f                               shrq $0x3f, %rsi
4010f3: 48 c1 f8 03                               sarq $0x3, %rax
4010f7: 48 01 c6                                  addq %rax, %rsi
4010fa: 48 d1 fe                                  sarq %rsi
4010fd: 74 11                                     je 0x11
4010ff:
4010ff: b8 00 00 00 00                            movl $0x0, %eax
401104: 48 85 c0                                  testq %rax, %rax
401107: 74 07                                     je 0x7
401109:
401109: bf 48 40 40 00                            movl $0x404048, %edi
40110e: ff e0                                     jmpq *%rax
401110:
401110: c3                                        retq

401120: <__do_global_dtors_aux>
401120:
401120: f3 0f 1e fa                               endbr64
401124:
401124: 80 3d 1d 2f 00 00 00                      cmpb $0x0, 0x2f1d(%rip)
40112b: 75 13                                     jne 0x13
40112d:
40112d: 55                                        pushq %rbp
40112e: 48 89 e5                                  movq %rsp, %rbp
401131: e8 7a ff ff ff                            callq -0x86
401136:
401136: c6 05 0b 2f 00 00 01                      movb $0x1, 0x2f0b(%rip)
40113d: 5d                                        popq %rbp
40113e: c3                                        retq
401140:
401140: c3                                        retq

401150: <frame_dummy>
401150:
401150: f3 0f 1e fa                               endbr64
401154:
401154: eb 8a                                     jmp -0x76

401160: <main>
401160:
401160: 55                                        pushq %rbp
401161: 48 89 e5                                  movq %rsp, %rbp
401164: 48 81 ec 10 01 00 00                      subq $0x110, %rsp
40116b: 48 8d 85 40 ff ff ff                      leaq -0xc0(%rbp), %rax
401172: 48 8d 4d 80                               leaq -0x80(%rbp), %rcx
401176: 31 f6                                     xorl %esi, %esi
401178: c7 45 fc 00 00 00 00                      movl $0x0, -0x4(%rbp)
40117f: 48 8d 55 c0                               leaq -0x40(%rbp), %rdx
401183: 48 89 d7                                  movq %rdx, %rdi
401186: ba 38 00 00 00                            movl $0x38, %edx
40118b: 48 89 95 30 ff ff ff                      movq %rdx, -0xd0(%rbp)
401192: 48 89 85 28 ff ff ff                      movq %rax, -0xd8(%rbp)
401199: 48 89 8d 20 ff ff ff                      movq %rcx, -0xe0(%rbp)
4011a0: e8 ab fe ff ff                            callq -0x155
4011a5:
4011a5: 48 8b 85 20 ff ff ff                      movq -0xe0(%rbp), %rax
4011ac: 48 89 c7                                  movq %rax, %rdi
4011af: 48 be 10 20 40 00 00 00 00 00             movabsq $0x402010, %rsi
4011b9: 48 8b 95 30 ff ff ff                      movq -0xd0(%rbp), %rdx
4011c0: e8 9b fe ff ff                            callq -0x165
4011c5:
4011c5: 48 c7 85 78 ff ff ff 00 00 00 00          movq $0x0, -0x88(%rbp)
4011d0: 48 8b 85 20 ff ff ff                      movq -0xe0(%rbp), %rax
4011d7: 48 89 85 78 ff ff ff                      movq %rax, -0x88(%rbp)
4011de: 48 8b 85 28 ff ff ff                      movq -0xd8(%rbp), %rax
4011e5: 48 89 c7                                  movq %rax, %rdi
4011e8: be ff 00 00 00                            movl $0xff, %esi
4011ed: 48 8b 95 30 ff ff ff                      movq -0xd0(%rbp), %rdx
4011f4: e8 57 fe ff ff                            callq -0x1a9
4011f9:
4011f9: 48 c7 85 38 ff ff ff 00 00 00 00          movq $0x0, -0xc8(%rbp)
401204: 48 8b 85 28 ff ff ff                      movq -0xd8(%rbp), %rax
40120b: 48 89 85 38 ff ff ff                      movq %rax, -0xc8(%rbp)
401212: 48 8b b5 78 ff ff ff                      movq -0x88(%rbp), %rsi
401219: 48 bf 48 20 40 00 00 00 00 00             movabsq $0x402048, %rdi
401223: b0 00                                     movb $0x0, %al
401225: e8 16 fe ff ff                            callq -0x1ea
40122a:
40122a: 48 8b 8d 78 ff ff ff                      movq -0x88(%rbp), %rcx
401231: 0f b7 31                                  movzwl (%rcx), %esi
401234: 48 bf 5b 20 40 00 00 00 00 00             movabsq $0x40205b, %rdi
40123e: 89 85 1c ff ff ff                         movl %eax, -0xe4(%rbp)
401244: b0 00                                     movb $0x0, %al
401246: e8 f5 fd ff ff                            callq -0x20b
40124b:
40124b: 48 8b 8d 78 ff ff ff                      movq -0x88(%rbp), %rcx
401252: 8b 71 04                                  movl 0x4(%rcx), %esi
401255: 48 bf 71 20 40 00 00 00 00 00             movabsq $0x402071, %rdi
40125f: 89 85 18 ff ff ff                         movl %eax, -0xe8(%rbp)
401265: b0 00                                     movb $0x0, %al
401267: e8 d4 fd ff ff                            callq -0x22c
40126c:
40126c: 48 8b b5 38 ff ff ff                      movq -0xc8(%rbp), %rsi
401273: 48 bf 87 20 40 00 00 00 00 00             movabsq $0x402087, %rdi
40127d: 89 85 14 ff ff ff                         movl %eax, -0xec(%rbp)
401283: b0 00                                     movb $0x0, %al
401285: e8 b6 fd ff ff                            callq -0x24a
40128a:
40128a: 48 8b 8d 38 ff ff ff                      movq -0xc8(%rbp), %rcx
401291: 0f b7 31                                  movzwl (%rcx), %esi
401294: 48 bf 9b 20 40 00 00 00 00 00             movabsq $0x40209b, %rdi
40129e: 89 85 10 ff ff ff                         movl %eax, -0xf0(%rbp)
4012a4: b0 00                                     movb $0x0, %al
4012a6: e8 95 fd ff ff                            callq -0x26b
4012ab:
4012ab: 48 8b 8d 38 ff ff ff                      movq -0xc8(%rbp), %rcx
4012b2: 8b 71 04                                  movl 0x4(%rcx), %esi
4012b5: 48 bf b2 20 40 00 00 00 00 00             movabsq $0x4020b2, %rdi
4012bf: 89 85 0c ff ff ff                         movl %eax, -0xf4(%rbp)
4012c5: b0 00                                     movb $0x0, %al
4012c7: e8 74 fd ff ff                            callq -0x28c
4012cc:
4012cc: 48 8b 8d 38 ff ff ff                      movq -0xc8(%rbp), %rcx
4012d3: 0f b7 31                                  movzwl (%rcx), %esi
4012d6: 41 b8 c4 00 00 00                         movl $0xc4, %r8d
4012dc: 41 39 f0                                  cmpl %esi, %r8d
4012df: 0f 85 1f 00 00 00                         jne 0x1f
4012e5:
4012e5: bf 41 00 00 00                            movl $0x41, %edi
4012ea: e8 41 fd ff ff                            callq -0x2bf
4012ef:
4012ef: bf 0a 00 00 00                            movl $0xa, %edi
4012f4: 89 85 08 ff ff ff                         movl %eax, -0xf8(%rbp)
4012fa: e8 31 fd ff ff                            callq -0x2cf
4012ff:
4012ff: e9 26 00 00 00                            jmp 0x26
401304:
401304: bf 2a 00 00 00                            movl $0x2a, %edi
401309: e8 22 fd ff ff                            callq -0x2de
40130e:
40130e: bf 0a 00 00 00                            movl $0xa, %edi
401313: 89 85 04 ff ff ff                         movl %eax, -0xfc(%rbp)
401319: e8 12 fd ff ff                            callq -0x2ee
40131e:
40131e: c7 45 fc ff ff ff ff                      movl $0xffffffff, -0x4(%rbp)
401325: e9 61 00 00 00                            jmp 0x61
40132a:
40132a: 48 8b 85 38 ff ff ff                      movq -0xc8(%rbp), %rax
401331: b9 00 ed de fa                            movl $0xfadeed00, %ecx
401336: 3b 48 04                                  cmpl 0x4(%rax), %ecx
401339: 0f 85 1f 00 00 00                         jne 0x1f
40133f:
40133f: bf 41 00 00 00                            movl $0x41, %edi
401344: e8 e7 fc ff ff                            callq -0x319
401349:
401349: bf 0a 00 00 00                            movl $0xa, %edi
40134e: 89 85 00 ff ff ff                         movl %eax, -0x100(%rbp)
401354: e8 d7 fc ff ff                            callq -0x329
401359:
401359: e9 26 00 00 00                            jmp 0x26
40135e:
40135e: bf 2a 00 00 00                            movl $0x2a, %edi
401363: e8 c8 fc ff ff                            callq -0x338
401368:
401368: bf 0a 00 00 00                            movl $0xa, %edi
40136d: 89 85 fc fe ff ff                         movl %eax, -0x104(%rbp)
401373: e8 b8 fc ff ff                            callq -0x348
401378:
401378: c7 45 fc ff ff ff ff                      movl $0xffffffff, -0x4(%rbp)
40137f: e9 07 00 00 00                            jmp 0x7
401384:
401384: c7 45 fc 00 00 00 00                      movl $0x0, -0x4(%rbp)
40138b:
40138b: 8b 45 fc                                  movl -0x4(%rbp), %eax
40138e: 48 81 c4 10 01 00 00                      addq $0x110, %rsp
401395: 5d                                        popq %rbp
401396: c3                                        retq

4013a0: <__libc_csu_init>
4013a0:
4013a0: f3 0f 1e fa                               endbr64
4013a4:
4013a4: 41 57                                     pushq %r15
4013a6: 4c 8d 3d 63 2a 00 00                      leaq 0x2a63(%rip), %r15
4013ad: 41 56                                     pushq %r14
4013af: 49 89 d6                                  movq %rdx, %r14
4013b2: 41 55                                     pushq %r13
4013b4: 49 89 f5                                  movq %rsi, %r13
4013b7: 41 54                                     pushq %r12
4013b9: 41 89 fc                                  movl %edi, %r12d
4013bc: 55                                        pushq %rbp
4013bd: 48 8d 2d 54 2a 00 00                      leaq 0x2a54(%rip), %rbp
4013c4: 53                                        pushq %rbx
4013c5: 4c 29 fd                                  subq %r15, %rbp
4013c8: 48 83 ec 08                               subq $0x8, %rsp
4013cc: e8 2f fc ff ff                            callq -0x3d1
4013d1:
4013d1: 48 c1 fd 03                               sarq $0x3, %rbp
4013d5: 74 1f                                     je 0x1f
4013d7:
4013d7: 31 db                                     xorl %ebx, %ebx
4013d9: 0f 1f 80 00 00 00 00                      #undefined
4013e0:
4013e0: 4c 89 f2                                  movq %r14, %rdx
4013e3: 4c 89 ee                                  movq %r13, %rsi
4013e6: 44 89 e7                                  movl %r12d, %edi
4013e9: 41 ff 14 df                               callq *(%r15,%rbx,8)
4013ed:
4013ed: 48 83 c3 01                               addq $0x1, %rbx
4013f1: 48 39 dd                                  cmpq %rbx, %rbp
4013f4: 75 ea                                     jne -0x16
4013f6:
4013f6: 48 83 c4 08                               addq $0x8, %rsp
4013fa: 5b                                        popq %rbx
4013fb: 5d                                        popq %rbp
4013fc: 41 5c                                     popq %r12
4013fe: 41 5d                                     popq %r13
401400: 41 5e                                     popq %r14
401402: 41 5f                                     popq %r15
401404: c3                                        retq

401410: <__libc_csu_fini>
401410:
401410: f3 0f 1e fa                               endbr64
401414:
401414: c3                                        retq

Disassembly of section .fini

401418: <_fini>
401418:
401418: f3 0f 1e fa                               endbr64
40141c:
40141c: 48 83 ec 08                               subq $0x8, %rsp
401420: 48 83 c4 08                               addq $0x8, %rsp
401424: c3                                        retq
