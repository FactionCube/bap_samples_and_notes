 ivg Gitter BAP  Jul 15, 2020

Just in case if you didn't notice, we are not using BIL anymore, yes you can reify a core theory term into a BIL program to enable existing analysis that are not yet Core Theory aware but this is just to enable compatibility and gradual upgrade of BAP infrastructure. Any analysis that still operates on BIL is non-extensible and limited to the concrete representation of BIL with all its problems. Here is the list of features that you can do with the Core Theory terms, but can't with BIL:

1) represent floating-point operations (including but not limited to IEEE754)

2) complex millicode instructions (that are too large for the concrete BIL representation, e.g., floating-point elementary functions or cryptographic extensions)

3) speculative execution and multithreading and, otherwise, model microarchitecture-specific details (e.g., all these atomic, fences, and other pipeline affecting operations)

4) model non-standard architectures, like PLC and microcontrollers

5) model high-level representations, such as JVM or CLR, and even programming languages like C

You can really benefit from reading the documentation where it is written what Core Theory is https://binaryanalysisplatform.github.io/bap/api/master/bap-core-theory/Bap_core_theory/index.html

