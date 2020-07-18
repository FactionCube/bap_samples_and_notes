From ivg at Gitter Bap:
Jul 16 2020

Dear Colleagues,

The #1119 PR is finally ready to be merged (as soon as we will get the green light 
from the mac os builds, which take hours). I have updated the PR message and hope 
you may find it interesting. I also update the Project module documentation to 
reflect the new algorithm that is used for building projects (since 2.0.0) and 
published several new interfaces. Namely

    Bap.Std.Toplevel to access Bap.Std internal knowlede base and evaluate toplevel 
    exrepssions

    Bap_main_event and Bap_main.Loggers that are now moved from Bap.Std so that we 
    can use our event system without bringing in Bap.Std

    Theory.Unit a new class in our knowledge base that denotes programs/libraries/objects 
    and other sets of instructions. It also overhauls the old and non-extensible `Arch.t` 
    abstraction with the new that is much more versatile and able to represent wilder 
    architectures.

And, of course, don't pass by the main feature, an ability to create as many projects 
as you like and store them in the same knowledge base. And even do bap compare 
callgraph /bin/* to compare the callgraphs of all functions in the /bin folder.

The feedback is as always welcome, and even if you read this message after the PR 
is merged don't hesitate to provide reviews, post suggestions, request changes, etc. 
Nothing is fixed in concrete until we have 2.2.0 release :)


