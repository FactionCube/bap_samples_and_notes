`$ bap objdump /bin/echo --show-insn=adt,asm | head -n 10`

```
SUB64ri8(Reg("RSP"), Reg("RSP"), Imm(0x8), Props())
subq $0x8, %rsp
MOV64rm(Reg("RAX"), Reg("RIP"), Imm(0x1), Reg("Nil"), Imm(0x206bcd), Reg("Nil"), Props(:load))
movq 0x206bcd(%rip), %rax
TEST64rr(Reg("RAX"), Reg("RAX"), Props())
testq %rax, %rax
JE_1(Imm(0x2), Props(:jump, :cond, :affect-control-flow))
je 0x2
CALL64r(Reg("RAX"), Props(:jump, :indirect, :call, :affect-control-flow, :store))
callq *%rax
```
