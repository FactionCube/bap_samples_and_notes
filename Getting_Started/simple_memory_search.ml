#require "bap-strings";;

open Core_kernel
open Bap_main
open Bap.Std
open Bap_strings.Std

let file_input_proj = Project.Input.file ~loader:"llvm" ~filename:
"/home/user/VENGEUR/Documents/BAP_Studies/CWE78/lisp/prn" |> Project.create |> ok_exn

let addr0 = Word.of_string "0x400594:32u"

let mem = Project.memory file_input_proj;;

let lkup = Memmap.lookup mem addr0;;

let mem_seq = Project.memory file_input_proj |> Memmap.to_sequence;;

let scan (mem,value) =
  let read n = match Memory.get ~disp:n mem with
    | Error _ -> None
    | Ok c -> match Word.to_int c with
      | Error _ -> assert false
      | Ok n -> Some (Char.of_int_exn n) in
  Strings.Scanner.run ~read 0 |>
  Seq.fold ~init:Addr.Map.empty ~f:(fun strs (off,str) ->
      Map.set strs
      ~key:(Addr.nsucc (Memory.min_addr mem) off)
      ~data:str)
;;


let min_length = 4;;

let union = Map.merge ~f:(fun ~key -> function
    | `Both (s1,s2) ->
      Option.some @@
      if String.length s1 > String.length s2 then s1 else s2
    | `Left s | `Right s -> Some s)
;;
let result = Seq.(mem_seq >>| scan |> reduce ~f:union) |> function
  | None -> Addr.Map.empty
  | Some strs -> Map.filteri strs ~f:(fun ~key ~data ->
      String.length data >= min_length)
;;

let collect ~min_length proj =
  let ms = Project.memory proj |> Memmap.to_sequence in
  Seq.(ms >>| scan |> reduce ~f:union) |> function
  | None -> Addr.Map.empty
  | Some strs -> Map.filteri strs ~f:(fun ~key ~data ->
      String.length data >= min_length)

let dd = collect file_input_proj;;
(* val dd : min_length:int -> string Addr.Map.t = <fun> *)

let escape = String.concat_map ~f:(function
    | '\n' -> "\\n"
    | '\t' -> "\\t"
    | '\r' -> "\\r"
    | c -> String.of_char c)

let print_str with_address =
  Map.iteri ~f:(fun ~key:addr ~data:str ->
      let str = escape str in
      if with_address
      then printf "%s: %s@\n" (Addr.string_of_value addr) str
      else printf "%s@\n" str)

(* Print strings for each address in the memory map. *)
let dd_it = Addr.Map.iteri dd ~f:(fun ~key:k ~data:d -> printf "%s %s\n" (Addr.string_of_value k) d)

let dd_it = Addr.Map.iter_keys dd ~f:(fun k -> printf "%s\n" (Addr.string_of_value k) ) 

let ss = Addr.Map.keys dd_it;;
(*
 * val ss : word list =
  [0x400238; 0x4002F9; 0x400303; 0x40030A; 0x40031C; 0x400328; 0x400510;
   0x400517; 0x40056A; 0x400594; 0x400657]
*)

let ans = Addr.Map.find_exn dd_it (List.nth_exn ss 9);;
(* val ans : string = "Spong" *)

let havit = Addr.Map.mem dd_it (List.nth_exn ss 9);;
(* val havit : bool = true *)
;;

