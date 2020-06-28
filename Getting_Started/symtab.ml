@ivg: "Symtab is returned by Project.symbols. The function Symtab.to_sequence will 
return a sequence of triplets (name,entry,cfg). The name is the function name. You 
can then print the CFG. If you like to print linearly you have to pick some traversal. 
Like you can just print them in the random order, or you can use reverse post order, 
or you can just sort them and print in the ascending address. I would pick reverse 
postorder, as it is more natural, e.g.,"

'''
module G = Graphs.Cfg

let insns cfg =
    Graphlib.reverse_postorder_traverse (module G) cfg |>
      Seq.map ~f:Block.insns |>
      Seq.concat_map ~f:Seq.of_list
'''
