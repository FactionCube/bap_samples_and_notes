open Core_kernel
open Bap_main
open Bap.Std


let file_input_proj = Project.Input.file ~loader:"llvm" ~filename:
"/home/user/VENGEUR/Documents/BAP_Studies/CWE78/lisp/prn" |> Project.create |> ok_exn

let prog = Project.program file_input_proj

let foo = Term.enum sub_t prog;;
let doo = Seq.map ~f:(fun s -> Term.enum arg_t s) foo;;
let doo = Seq.map ~f:(fun s -> s) foo;;
let ten = Seq.nth_exn doo 10;;
let ten_blks = Term.enum blk_t ten;;
let ten_tid = Term.tid ten;;
let trm_name = Term.name ten;;

let tid_namer = object
    inherit [Tid.t] Term.visitor
    method! enter_sub _ tmid = tmid
  end

let namer = object
    inherit [Sub.t] Term.visitor
    method! enter_sub _ sub = sub
  end

let tid_main prg termid =
  (* let subs = namer#run prg (Sub.create ()) in  *)
  let subs = tid_namer#run prg (termid) in
  printf "subs = %s\n" (Term.name termid)


let main prg termid =
  (* let subs = namer#run prg (Sub.create ()) in  *)
  let subs = namer#run prg in
  printf "subs = %s\n" (Sub.name subs)

;;


