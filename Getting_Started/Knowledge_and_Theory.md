Ivan Gotovchits
@ivg
Jul 13 23:51
The knowledge base is used by nearly all bap plugins and components either directly or indirectly, e.g., just do `grep -re 'open Bap_knowledge\|open Bap_core_theory'` in the main repository to list them. You can also read this blog post to get a high-level picture. Basically, the whole interface distills to only three functions: collect, provide, and promise. With collect you read the properties, with provide you set them, and with promise you register a function that computes properties. And do not forget to read the documentation.

Ivan Gotovchits
@ivg
Jul 14 02:36
To get an overall picture you can do `bap list classes`, it will show all classses and their public properties. Finding a corresponding OCaml slot to access the properties might be a bit tricky, but here are a few advice:

1) Theory.Program is the OCaml interface to the `core-theory:program` class, which the main class in BAP, as it denotes programs and their semantics.

2) In bap.mli you can find a few slots that are more BAP 1.x specific, you can just do `C-M-s \bslot\b` to go through them.

3) You can either use rgrep in Emacs or `find -name '*.mli' | xargs grep -e '\bslot\b'` to mine all the slots from the public interface.

4) Finally, when you see an interesting slot in the bap list classes output and can't find it in mli, you can try to find its definition and then look at the corresponding mli file, e.g., `find -name '*.ml' | xargs grep -e label-aliases`
