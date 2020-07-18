open Bap.Std;;
(* Set up an address. *);;

let addr0 = Addr.of_string "0x400100:32u";;
(* val addr0 : word = 0x400100 *)

(* Alternate method. *);;
let word0 = Word.of_int32 0x400100l;;
(* val word0 : word = 0x400100 *)

let eq = addr0 = word0;;
(* val eq : bool = true *)

let f4 = Word.of_int32 0x000000f4l;;
(* val f4 : word = 0xF4 *)

let bword = Word.of_bool true;;
(* val bword : word = 1 *)

let neg = ~- 0xf4;;
(* val neg : int = -244 *)

let ones = Word.ones 0x5;;
(* val ones : word = 0x1F *)

# let ones = Word.ones 0x05;;
(* val ones : word = 0x1F *)

let ones = Word.ones 0x00;;
(* val ones : word = 0 *)

let ones = Word.ones 0x01;;
(* val ones : word = 1 *)

let bv = Word.to_bitvec f4;;
(* val bv : Bitvec.t = <abstr> *)

let prn = Format.printf "\t%a\n" Word.pp_hex f4;;
        0xF4
(* val prn : unit = () *)


let prn = Format.printf "\t%a\n" Word.pp_bin_full f4;;
	0b11110100:8u
(* val prn : unit = () *)

let enums = Word.enum_bits f4 BigEndian;;
(* val enums : bool seq = {true, true, true, true, false, true, false, false} *)

