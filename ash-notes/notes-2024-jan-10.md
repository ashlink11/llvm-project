# getting started with llvm

## terminology & notation

`SRC_ROOT`

This is the top level directory of the LLVM source tree.

`OBJ_ROOT`

This is the top level directory of the LLVM object tree (i.e. the tree where object files and compiled programs will be placed. It can be the same as SRC_ROOT).

## unpacking the llvm archives

If you have the LLVM distribution, you will need to unpack it before you can begin to compile it. LLVM is distributed as a number of different subprojects. Each one has its own download which is a TAR archive that is compressed with the gzip program.

The files are as follows, with x.y marking the version number:

`llvm-x.y.tar.gz`

Source release for the LLVM libraries and tools.

`cfe-x.y.tar.gz`

Source release for the Clang frontend.