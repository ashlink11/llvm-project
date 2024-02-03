brew install llvm

To use the bundled libc++ please add the following LDFLAGS:
  LDFLAGS="-L/usr/local/opt/llvm/lib/c++ -Wl,-rpath,/usr/local/opt/llvm/lib/c++"

llvm is keg-only, which means it was not symlinked into /usr/local,
because macOS already provides this software and installing another version in
parallel can cause all kinds of trouble.

If you need to have llvm first in your PATH, run:
  echo 'export PATH="/usr/local/opt/llvm/bin:$PATH"' >> ~/.zshrc

For compilers to find llvm you may need to set:
  export LDFLAGS="-L/usr/local/opt/llvm/lib"
  export CPPFLAGS="-I/usr/local/opt/llvm/include"


/usr/local/bin/cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE -DCMAKE_C_COMPILER:FILEPATH=/usr/bin/clang -DCMAKE_CXX_COMPILER:FILEPATH=/usr/bin/clang++ -S/Users/ash/dev/llvm-project -B/Users/ash/dev/llvm-project/build -G Ninja


rm -rf build
cmake .
make

brew info llvm
==> llvm: stable 17.0.6 (bottled), HEAD [keg-only]
Next-gen compiler infrastructure
https://llvm.org/
/usr/local/Cellar/llvm/17.0.6_1 (7,207 files, 1.8GB)
  Poured from bottle using the formulae.brew.sh API on 2024-02-02 at 17:29:55
From: https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/l/llvm.rb
License: Apache-2.0 with LLVM-exception
==> Dependencies
Build: cmake ✘, ninja ✘, swig ✘
Required: python@3.12 ✔, z3 ✔, zstd ✔
==> Options
--HEAD
	Install HEAD version
==> Caveats
To use the bundled libc++ please add the following LDFLAGS:
  LDFLAGS="-L/usr/local/opt/llvm/lib/c++ -Wl,-rpath,/usr/local/opt/llvm/lib/c++"

llvm is keg-only, which means it was not symlinked into /usr/local,
because macOS already provides this software and installing another version in
parallel can cause all kinds of trouble.

If you need to have llvm first in your PATH, run:
  echo 'export PATH="/usr/local/opt/llvm/bin:$PATH"' >> ~/.zshrc

For compilers to find llvm you may need to set:
  export LDFLAGS="-L/usr/local/opt/llvm/lib"
  export CPPFLAGS="-I/usr/local/opt/llvm/include"
==> Analytics
install: 57,004 (30 days), 159,662 (90 days), 423,946 (365 days)
install-on-request: 24,791 (30 days), 74,857 (90 days), 289,454 (365 days)
build-error: 581 (30 days)


C/C++ configuration extension
```
${workspaceFolder}/llvm/include/**
${workspaceFolder}/utils/bazel/llvm-project-overlay/llvm/include/**
${workspaceFolder}/build/include/**
```