 
 ./configure --enable-everything --enable-llvm --with-llvm-config=/usr/lib/llvm-10/bin/llvm-config --with-llvm-version=10.0.0 --disable-ida --prefix=`opam config var prefix` --objdump-path=/usr/bin/objdump --objdump-targets=["\"elf64-x86-64\";\"elf32-i386\";\"pe-i386\";\"pe-x86-64\";\"elf32-powerpc\";\"elf64-powerpc\";"]
