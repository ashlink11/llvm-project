# plan (low-level):

(from `plan`: #6, #10, #11, #13, #17, #18, #19) 

   6. review llvm infra high-level
   10. undertand ModuleMaker project source filetree
   11. review llvm infra low-level (ie what is an LLVM "library" and why does it have diff meanings?) 
   13. review ModuleMaker code to determine C++ version and libs needed to run it for the config, headers, etc., so i can make sure to have those header files in the LLVM install
   17. which is the proper LLVM installation? and which can i use to build a project and which are simply for running my own system's clang compiler?
       1.  VSCode extension
       2.  Xcode / native
       3.  CMake generates?
       4.  git clone - but where is it installed on my computer? (i.e. how to set `PATH`)
   18. test diff CMake configs
       1.  find OSS examples on gh, etc.
       2.  learn more basics from `dev/CMake-fork` repo
   19. do i need to be able to see all the header/lib files in the LLVM source install? or are some generated with CMake? 

- llvm version == clang version 

### `homebrew clang`

```bash
clang --version
```

```bash
Homebrew clang version 17.0.6
Target: x86_64-apple-darwin23.3.0
Thread model: posix
InstalledDir: /usr/local/opt/llvm/bin
The current version of LLVM/clang as of today, February 24, 2024, is 17.0.6.
darwin23.3.0 corresponds to macOS Ventura 13.3.
```

> Depending on the project and your Clang installation, you might need to specify a `sysroot` directory containing the system headers and libraries needed for compilation. Use the `-isysroot` flag with `clang` or configure it in `CMake`.
>
> ... environment variables like `CC` and `CXX` or through CMake options like `CMAKE_C_COMPILER` and `CMAKE_CXX_COMPILER`.
> 
> Complex projects might require additional libraries or tools not installed by default with `homebrew clang`. You might need to install them separately using Homebrew or other methods.
> 
> Make sure your Homebrew Clang version is compatible with the project's requirements. Check the project documentation or the `CMakeLists.txt` file for the required `clang` version range.
> `homebrew clang` might not have all necessary dependencies linked by default. You might need to link them manually using `-L` and `-l` flags or install additional packages with `homebrew`.

**results**: 
- at least one version is installed with homebrew in `/usr/local/opt/llvm/bin`
- llvm is compatible with latest macOS Sonoma
- use `-isysroot` for config to find headers & libs
- check for all libraries and tools needed for project. `homebrew`, etc. can install them separately
- check if project's `CXX` version is compatible with installed `clang`, etc.
  



### `Xcode`

> Xcode 14.3.1 is not compatible with Sonoma 14.3.1: Apple discontinued support for Xcode 14 with the release of Ventura 13, and it will not work on Sonoma.

result:
- Xcode is deprecated
- make sure I dont have XCode still installed from pre-update



### LLVM-project (`git clone`)

> `PATH` variable: If you install LLVM outside the default location, you might need to adjust your `PATH` environment variable to access the tools correctly.

result: look for next bash commands to find/create source & project root dirs once i have a clean gh install and proper dir layout btw source & project



### next steps: (sun feb 25, 2024)
- make sure I dont have `XCode` still installed from old macOS versions
- explore LLVM compiler browser envs too
- check `homebrew clang` and `git clone` are the same version
- continue with `homebrew` method
- continue with `git clone` method 



# next day

```bash
xcodebuild -version

>_ xcode-select: error: tool 'xcodebuild' requires Xcode, but active developer directory '/Library/Developer/CommandLineTools' is a command line tools instance
```

- also Xcode is not in my Applications folder
- i think Sonoma uninstalled it


```bash
clang --version

>_ Homebrew clang version 17.0.6
Target: x86_64-apple-darwin23.3.0
Thread model: posix
InstalledDir: /usr/local/opt/llvm/bin

brew list llvm

>_ /usr/local/Cellar/llvm/17.0.6_1/bin/FileCheck
/usr/local/Cellar/llvm/17.0.6_1/bin/UnicodeNameMappingGenerator
/usr/local/Cellar/llvm/17.0.6_1/bin/amdgpu-arch
/usr/local/Cellar/llvm/17.0.6_1/bin/analyze-build
/usr/local/Cellar/llvm/17.0.6_1/bin/bugpoint
/usr/local/Cellar/llvm/17.0.6_1/bin/c-index-test
/usr/local/Cellar/llvm/17.0.6_1/bin/clang
/usr/local/Cellar/llvm/17.0.6_1/bin/clang++
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-17
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-apply-replacements
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-change-namespace
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-check
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-cl
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-cpp
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-doc
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-extdef-mapping
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-format
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-include-cleaner
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-include-fixer
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-linker-wrapper
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-move
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-offload-bundler
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-offload-packager
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-pseudo
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-query
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-refactor
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-rename
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-reorder-fields
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-repl
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-scan-deps
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-tblgen
/usr/local/Cellar/llvm/17.0.6_1/bin/clang-tidy
/usr/local/Cellar/llvm/17.0.6_1/bin/clangd
/usr/local/Cellar/llvm/17.0.6_1/bin/clangd-xpc-test-client
/usr/local/Cellar/llvm/17.0.6_1/bin/count
/usr/local/Cellar/llvm/17.0.6_1/bin/darwin-debug
/usr/local/Cellar/llvm/17.0.6_1/bin/diagtool
/usr/local/Cellar/llvm/17.0.6_1/bin/dsymutil
/usr/local/Cellar/llvm/17.0.6_1/bin/find-all-symbols
/usr/local/Cellar/llvm/17.0.6_1/bin/git-clang-format
/usr/local/Cellar/llvm/17.0.6_1/bin/hmaptool
/usr/local/Cellar/llvm/17.0.6_1/bin/intercept-build
/usr/local/Cellar/llvm/17.0.6_1/bin/ld.lld
/usr/local/Cellar/llvm/17.0.6_1/bin/ld64.lld
/usr/local/Cellar/llvm/17.0.6_1/bin/llc
/usr/local/Cellar/llvm/17.0.6_1/bin/lld
/usr/local/Cellar/llvm/17.0.6_1/bin/lld-link
/usr/local/Cellar/llvm/17.0.6_1/bin/lldb
/usr/local/Cellar/llvm/17.0.6_1/bin/lldb-argdumper
/usr/local/Cellar/llvm/17.0.6_1/bin/lldb-instr
/usr/local/Cellar/llvm/17.0.6_1/bin/lldb-server
/usr/local/Cellar/llvm/17.0.6_1/bin/lldb-vscode
/usr/local/Cellar/llvm/17.0.6_1/bin/lli
/usr/local/Cellar/llvm/17.0.6_1/bin/lli-child-target
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-PerfectShuffle
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-addr2line
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-ar
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-as
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-bcanalyzer
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-bitcode-strip
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-c-test
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-cat
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-cfi-verify
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-config
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-cov
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-cvtres
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-cxxdump
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-cxxfilt
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-cxxmap
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-debuginfo-analyzer
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-debuginfod
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-debuginfod-find
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-diff
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-dis
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-dlltool
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-dwarfdump
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-dwarfutil
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-dwp
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-exegesis
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-extract
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-gsymutil
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-ifs
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-install-name-tool
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-jitlink
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-jitlink-executor
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-lib
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-libtool-darwin
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-link
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-lipo
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-lto
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-lto2
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-mc
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-mca
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-ml
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-modextract
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-mt
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-nm
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-objcopy
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-objdump
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-opt-report
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-otool
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-pdbutil
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-profdata
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-profgen
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-ranlib
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-rc
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-readelf
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-readobj
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-reduce
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-remark-size-diff
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-remarkutil
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-rtdyld
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-sim
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-size
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-split
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-stress
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-strings
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-strip
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-symbolizer
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-tapi-diff
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-tblgen
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-tli-checker
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-undname
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-windres
/usr/local/Cellar/llvm/17.0.6_1/bin/llvm-xray
/usr/local/Cellar/llvm/17.0.6_1/bin/mlir-cpu-runner
/usr/local/Cellar/llvm/17.0.6_1/bin/mlir-linalg-ods-yaml-gen
/usr/local/Cellar/llvm/17.0.6_1/bin/mlir-lsp-server
/usr/local/Cellar/llvm/17.0.6_1/bin/mlir-opt
/usr/local/Cellar/llvm/17.0.6_1/bin/mlir-pdll
/usr/local/Cellar/llvm/17.0.6_1/bin/mlir-pdll-lsp-server
/usr/local/Cellar/llvm/17.0.6_1/bin/mlir-reduce
/usr/local/Cellar/llvm/17.0.6_1/bin/mlir-tblgen
/usr/local/Cellar/llvm/17.0.6_1/bin/mlir-translate
/usr/local/Cellar/llvm/17.0.6_1/bin/modularize
/usr/local/Cellar/llvm/17.0.6_1/bin/not
/usr/local/Cellar/llvm/17.0.6_1/bin/nvptx-arch
/usr/local/Cellar/llvm/17.0.6_1/bin/obj2yaml
/usr/local/Cellar/llvm/17.0.6_1/bin/opt
/usr/local/Cellar/llvm/17.0.6_1/bin/pp-trace
/usr/local/Cellar/llvm/17.0.6_1/bin/run-clang-tidy
/usr/local/Cellar/llvm/17.0.6_1/bin/sancov
/usr/local/Cellar/llvm/17.0.6_1/bin/sanstats
/usr/local/Cellar/llvm/17.0.6_1/bin/scan-build
/usr/local/Cellar/llvm/17.0.6_1/bin/scan-build-py
/usr/local/Cellar/llvm/17.0.6_1/bin/scan-view
/usr/local/Cellar/llvm/17.0.6_1/bin/set-xcode-analyzer
/usr/local/Cellar/llvm/17.0.6_1/bin/split-file
/usr/local/Cellar/llvm/17.0.6_1/bin/tblgen-lsp-server
/usr/local/Cellar/llvm/17.0.6_1/bin/verify-uselistorder
/usr/local/Cellar/llvm/17.0.6_1/bin/wasm-ld
/usr/local/Cellar/llvm/17.0.6_1/bin/yaml-bench
/usr/local/Cellar/llvm/17.0.6_1/bin/yaml2obj
/usr/local/Cellar/llvm/17.0.6_1/include/c++/ (1014 files)
/usr/local/Cellar/llvm/17.0.6_1/include/clang/ (723 files)
/usr/local/Cellar/llvm/17.0.6_1/include/clang-c/ (13 files)
/usr/local/Cellar/llvm/17.0.6_1/include/clang-tidy/ (371 files)
/usr/local/Cellar/llvm/17.0.6_1/include/lld/ (14 files)
/usr/local/Cellar/llvm/17.0.6_1/include/lldb/ (526 files)
/usr/local/Cellar/llvm/17.0.6_1/include/llvm/ (1849 files)
/usr/local/Cellar/llvm/17.0.6_1/include/llvm-c/ (28 files)
/usr/local/Cellar/llvm/17.0.6_1/include/mach-o/ (2 files)
/usr/local/Cellar/llvm/17.0.6_1/include/mlir/ (1322 files)
/usr/local/Cellar/llvm/17.0.6_1/include/mlir-c/ (34 files)
/usr/local/Cellar/llvm/17.0.6_1/include/polly/ (112 files)
/usr/local/Cellar/llvm/17.0.6_1/include/ (6 files)
/usr/local/Cellar/llvm/17.0.6_1/lib/libClangdXPCLib.dylib
/usr/local/Cellar/llvm/17.0.6_1/lib/libLLVM-C.dylib
/usr/local/Cellar/llvm/17.0.6_1/lib/libLLVM.dylib
/usr/local/Cellar/llvm/17.0.6_1/lib/libLTO.dylib
/usr/local/Cellar/llvm/17.0.6_1/lib/libMLIR.dylib
/usr/local/Cellar/llvm/17.0.6_1/lib/libRemarks.dylib
/usr/local/Cellar/llvm/17.0.6_1/lib/libclang-cpp.dylib
/usr/local/Cellar/llvm/17.0.6_1/lib/libclang.dylib
/usr/local/Cellar/llvm/17.0.6_1/lib/liblldb.17.0.6.dylib
/usr/local/Cellar/llvm/17.0.6_1/lib/libmlir_async_runtime.dylib
/usr/local/Cellar/llvm/17.0.6_1/lib/libmlir_c_runner_utils.dylib
/usr/local/Cellar/llvm/17.0.6_1/lib/libmlir_float16_utils.dylib
/usr/local/Cellar/llvm/17.0.6_1/lib/libmlir_runner_utils.dylib
/usr/local/Cellar/llvm/17.0.6_1/lib/libomp.dylib
/usr/local/Cellar/llvm/17.0.6_1/lib/libunwind.1.0.dylib
/usr/local/Cellar/llvm/17.0.6_1/lib/c++/ (9 files)
/usr/local/Cellar/llvm/17.0.6_1/lib/clang/ (252 files)
/usr/local/Cellar/llvm/17.0.6_1/lib/cmake/ (60 files)
/usr/local/Cellar/llvm/17.0.6_1/lib/libear/ (3 files)
/usr/local/Cellar/llvm/17.0.6_1/lib/libscanbuild/ (11 files)
/usr/local/Cellar/llvm/17.0.6_1/lib/objects-Release/ (38 files)
/usr/local/Cellar/llvm/17.0.6_1/lib/python3.10/ (3 files)
/usr/local/Cellar/llvm/17.0.6_1/lib/python3.11/ (3 files)
/usr/local/Cellar/llvm/17.0.6_1/lib/python3.12/ (3 files)
/usr/local/Cellar/llvm/17.0.6_1/lib/python3.7/ (3 files)
/usr/local/Cellar/llvm/17.0.6_1/lib/python3.8/ (3 files)
/usr/local/Cellar/llvm/17.0.6_1/lib/python3.9/ (3 files)
/usr/local/Cellar/llvm/17.0.6_1/lib/ (548 other files)
/usr/local/Cellar/llvm/17.0.6_1/libexec/python3.12/ (28 files)
/usr/local/Cellar/llvm/17.0.6_1/libexec/ (6 files)
/usr/local/Cellar/llvm/17.0.6_1/share/clang/ (11 files)
/usr/local/Cellar/llvm/17.0.6_1/share/emacs/ (7 files)
/usr/local/Cellar/llvm/17.0.6_1/share/man/man1/scan-build.1
/usr/local/Cellar/llvm/17.0.6_1/share/opt-viewer/ (6 files)
/usr/local/Cellar/llvm/17.0.6_1/share/scan-build/ (2 files)
/usr/local/Cellar/llvm/17.0.6_1/share/scan-view/ (4 files)
/usr/local/Cellar/llvm/17.0.6_1/share/vim/ (16 files)
/usr/local/Cellar/llvm/17.0.6_1/Toolchains/LLVM17.0.6.xcto

```

- listed above are all the installed versions of llvm, which includes clang
  - looks like native clang is at 17.0.6 
  - and brew clang is at 17.0.6 also
- learned something new even tho ive been using it for years: homebrew is a package manager for bash
- the homebrew root is `/usr/local/Cellar/` to hold its packages
- this avoids conflicts with system default directories
- holds installed compilers for C, C++, Rust, etc.



```bash
which clang

>_ /usr/local/opt/llvm/bin/clang
```

- this means there's a native `clang` in `usr/local/opt/` but actually looks like it should be in `usr/bin` or `usr/local/bin/`
- `opt` means optional add-on software
- the Filesystem Hierarchy Standard (FHS) is system native software
- 



```bash
brew which clang

>_ Error: Unknown command: which
```

- seems like brew doesnt have full `clang` installed ???



```bash
echo $PATH

>_ /usr/local/opt/llvm/bin
/Library/Frameworks/Python.framework/Versions/3.11/bin
/usr/local/bin
/usr/bin
/bin
/usr/sbin
/sbin
~/.cargo/bin
/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin
/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin
/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin
/usr/local/go/bin
/Users/ash/.cargo/bin 
```

- above are the places where FHS looks for clang, so i need to research this next
- does look like its searching `/opt/` first though



### next steps: (mon feb 26, 2024)
- explore LLVM compiler browser envs too
- continue with `homebrew` method?
- continue with `git clone` method?
- understand `$PATH` config
- should I create my own CMake config or use the VSCode CMake tools extension?

what `echo $PATH` returns:
- various executables, including compilers, interpreters, system utilities, system utility directories, development tool directories, or custom script directories, etc.

> "By default, your LLVM project will not use the code from your local Git repository, regardless of its location. It will instead use the installed LLVM version present in your system's $PATH."
> "Downloading the llvm-project repository from Git is primarily for development purposes and not directly for running existing projects."
> "In specific cases, you might need a particular LLVM version not readily available in your system's package manager. Downloading the repository allows you to build and install a custom version tailored to your project's requirements."
> "You would need to configure and compile the entire LLVM suite, including Clang, libraries, and other tools. This can be a time-consuming and involved process."
> "Pre-built binary distributions or packages from your system's package manager often provide a simpler and more reliable way to obtain the necessary LLVM tools for running projects."


use these for my CMake config to find the llvm/clang installed on my system

```
find_package(Clang REQUIRED)
target_link_libraries(my_project PRIVATE Clang)
```

then: ("how should i write my cmake config?")

```
project(my_project)


// depending on whether you're building an executable or library:
add_executable(my_executable main.cpp other_file.cpp)
// or 
add_library(my_library source1.cpp source2.cpp)


//Target Configuration: Use 
target_link_libraries(my_executable PRIVATE my_library) 
// to link your executable against your library or other external libraries found by find_package().


// Install Targets: Use 
install(TARGETS my_executable my_library DESTINATION bin)
// to specify where to install executables and libraries during the build process.
```

result of the VSCode CMake tools extension:

```
No current configuration is defined in the workspace state. Assuming 'Default'.
No target defined in the workspace state. Assuming 'Default'.
Dropping various extension output files at /Users/ash/Library/Application Support/Code/User/workspaceStorage/6517dd5d9245451cd6111a4d2aee3d59/ms-vscode.makefile-tools
Logging level: Normal
Configurations cached at /Users/ash/Library/Application Support/Code/User/workspaceStorage/6517dd5d9245451cd6111a4d2aee3d59/ms-vscode.makefile-tools/configurationCache.log
No path to the makefile is defined in the settings file.
No folder path to the makefile is defined in the settings file.
Always pre-configure: false
Always post-configure: false
Dry-run switches: '--always-make', '--keep-going', '--print-directory'
No current launch configuration is set in the workspace state.
Default launch configuration: MIMode = undefined,
                    miDebuggerPath = undefined,
                    stopAtEntry = undefined,
                    symbolSearchPath = undefined
Configure on open: true
Configure on edit: true
Configure after command: true
Only .PHONY targets: false
Save before build or configure: true
Build before launch: true
Clear output before build: true
Ignore directory commands: true
compile_commands.json path: null
Deduced command 'make ' for configuration "Default"
The Makefile Tools extension process of configuring your project is about to run 'make --dry-run' in order to parse the output for useful information. This is needed to calculate accurate IntelliSense and targets information. Although in general 'make --dry-run' only lists (without executing) the operations 'make' would do in the current context, it is still possible some code to be executed, like $(shell) syntax in the makefile or recursive invocations of the $(MAKE) variable.
If you don't feel comfortable allowing this configure process and 'make --dry-run' to be invoked by the extension, you can chose a recent full, clean, verbose and up-to-date build log as an alternative, via the setting 'makefile.buildLog'. 
```

- looks like ^ can't find my makefile because I gave it the wrong path, so it assumes default

- this is my new `CMakeLists.txt` files:

```
find_package(Clang REQUIRED)
target_link_libraries(ModuleMakerTest PRIVATE Clang)

project(ModuleMakerTest)


# depending on whether you're building an executable or library:
add_executable(adder ModuleMakerTest.cpp)
# or 
# add_library(my_library source1.cpp source2.cpp)

# Executable Name: This refers to the specific file generated after compilation, the actual program you run. It can be descriptive, but doesn't necessarily need to directly reflect the entire project name.

# do i have any external libraries?
# //Target Configuration: Use 
# target_link_libraries(my_executable PRIVATE my_library) 
# // to link your executable against your library or other external libraries found by find_package().

# i think the auto build dir is sufficient
# // Install Targets: Use 
# install(TARGETS my_executable my_library DESTINATION bin)
# // to specify where to install executables and libraries during the build process.
```


- attempting to run `ModuleMakerTest` repo code:

1. build:

```bash
cmake .
```
result:
```bash
-- Configuring done
-- Generating done
-- Build files have been written to: /Users/ash/dev/ModuleMakerTest
```

2. compile:

```bash
make
```

result: (lots of the same errors)

```bash
error: unknown type name
""
""
```

plus, in my source file:

```bash
#include errors detected. Please update your includePath. Squiggles are disabled for this translation unit (/Users/ash/dev/ModuleMakerTest/ModuleMakerTest.cpp).C/C++(1696)
cannot open source file "llvm/Bitcode/BitcodeWriter.h"C/C++(1696)
```

to fix:

```bash
brew install llvm
```
result:
```bash
Warning: llvm 17.0.6_1 is already installed and up-to-date.
To reinstall 17.0.6_1, run:
  brew reinstall llvm
```

- Q: is `17.0.6_1` the same as `17.0.6` ??? #todo

> "Pre-built Binaries: Alternatively, you can download and install pre-built binary packages from the official LLVM website (https://releases.llvm.org/download.html). This often requires additional configuration to set up environment variables and integration with your build system."

- instructions: (afterfrom `git clone llvm-project`)

```bash
cd llvm-project

cmake -S llvm -B build -G <generator> [options]
```

- i've tried this a lot. maybe i could try configuring it properly. i wonder why i dont have the proper dev libraries installed in my native system #todo

next steps: 
- learn how to install the proper llvm dev libraries 