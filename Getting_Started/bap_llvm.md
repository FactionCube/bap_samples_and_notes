Paraphrasing Ivan Gotovchits
@ivg
May 04 23:41

When you first install bap it installs the conf-bap-llvm package, which is a proxy package 
representing the system llvm installation. It records all the paths and configuration of the 
package. If you change the system version of the package, you have to reinstall this 
package to propagate the changes to opam, e.g., opam reinstall conf-bap-llvm.
To make sure that it detected the version correctly, check it with

	opam config var conf-bap-llvm:package-version

This command will output the llvm version. To further troubleshoot the llvm installation use the

	opam config var conf-bap-llvm:config

which outputs the full path to the llvm-config binary, which is the main provider of the llvm configuration.
You can tell BAP which version to use:

	export LLVM_CONFIG=/usr/bin/llvm-config-10
or
	opam config set llvm-config llvm-config-10
then run
	opam reinstall conf-bap-llvm

Then you can proceed with bap installation as normal, e.g., opam install bap.
