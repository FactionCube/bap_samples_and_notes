For drilling down into sub/block/etc

```
open Core_kernel
open Bap_main
open Bap.Std

let main proj =
  let prog = Project.program proj in
  Seq.iter (Term.enum sub_t prog)
    ~f:(fun sub ->
        begin
          Seq.iter (Term.enum blk_t sub)
           ~f:(fun blk -> Seq.iter (Term.enum phi_t blk) ~f:(fun phi -> let phi_str = Phi.to_string phi in print_string phi_str))
        end)

let () = Extension.declare @@ fun _ctxt ->
  Project.register_pass' main;
  Ok ()
  ```

