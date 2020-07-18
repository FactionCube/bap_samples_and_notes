ivg Gitter Bap Jul 14, 2020

You can use `Input.create`  e.g.,
```
let project_of_string  ?(base=0L) arch  str =
  let file = "/dev/null" in
  let endian = Arch.endian arch in
  let width = Size.in_bits @@ Arch.addr_size arch in
  let base = Word.of_int64 ~width base in
  let input =
    let mem =
      Memory.create endian base (Bigstring.of_string str) |> ok_exn in
    let code =
      Memmap.add Memmap.empty mem (Value.create Image.section "user") in
    let data = Memmap.empty in
    Project.Input.create arch file ~code ~data
```

It still requires the filename to enable interoperability with system tools such as IDA, radare2, objdump, etc, but passing `/dev/null` or `""` there should be fine, they will just fail. Of course, it is still a good idea to have a file so that you can benefit from those tools.

