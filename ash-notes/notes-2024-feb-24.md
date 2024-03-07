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


# next day (wed feb 28)

- "You can search for specific libraries like `libclang.dylib`, `libLLVM.dylib`, etc., in their usual locations, such as /usr/lib or directories within the Xcode installation path."
- If you encounter missing libraries when trying to build your project, consider using a package manager like Homebrew (https://brew.sh/) to install specific versions of LLVM/Clang.
- Refer to your project's documentation or online resources for specific library requirements and build instructions.
- "Try building your project using the appropriate build commands (e.g., `cmake .. && make` or instructions specific to your project)."
- "Look through the source code (especially C++ files) for code blocks mentioning libraries using keywords like `#pragma comment(lib, "...")` or functions like `extern "C" { ... }`. These sections might indicate the libraries your project depends on."
- "missing the header file `BitcodeWriter.h`, which is part of the LLVM Bitcode library."
- "The specific library name may vary slightly depending on your system and LLVM version. It's typically named `libLLVMBitWriter.a` or `libLLVMBitWriter.dylib`"
- "CMake should locate the library automatically if it's installed in a standard location. If not, you might need to specify the path to the library using `find_library` or similar commands.
- Compiling manually: Use the appropriate compiler flags to link against the library. For example, with the Clang compiler, you'd use the `-lLLVMBitWriter` flag."
- "Ensure your compiler/build system is searching in the correct locations for libraries. You may need to adjust library search paths in your build settings."
- "If you encounter specific errors, search for solutions online in forums like LLVM Discourse [llvm dev forum](https://discourse.llvm.org/) or relevant communities."


### attempt at high-level CMake understanding

- [2023 llvm yt advanced CMake for Windows](https://www.youtube.com/watch?v=zlD2MpU7XIw)
- [llvm.org ASM/.a/assembly lang reference manual with high-level module, etc. structure, instruction reference, intrinsics functions reference, ](https://llvm.org/docs/LangRef.html)
- [Getting Started with LLVM Core Libraries 2014 book](https://www.amazon.com/dp/1782166920/ref=sm_n_se_dkp_DZ_pr_sea_0_0)
  - "Configure, build, and install extra LLVM open source projects including Clang tools, static analyzer, Compiler-RT, LLDB, DragonEgg, libc++, and LLVM test-suite"
  - "Understand the LLVM library design and interaction between libraries and standalone tools"
- [VSCode remote-SSH virtual machine setup tutorial](https://www.linaro.org/blog/how-to-set-up-vs-code-for-llvm-development/)
  - all VSCode extensions to install
  - add LLVM JSON configs for custom compiler kits
  - select a kit
  - select a variance
- [C++ CMake and VSCode tutorial extremely simple program with a library](https://computingonplains.wordpress.com/building-c-applications-with-cmake-and-visual-studio-code/)
- [C++ Cmake and VScode github source code for extremely simple program tutorial for Windows with MSVC compiler](https://github.com/gvcallen/CMake-VSCode-Tutorial)
  - CPP-Tools extension
  - CMake Tools extension
  - CMake extension
- [C++ Cmake and VScode extremely simple program tutorial](https://medium.com/@sam.romano18/visual-studio-code-setup-for-beginners-using-c-and-cmake-e92ab4f1fba1)
  - tasks.json file crucial to compiling
  - extremely simple cpp code and CMake config 


### continuing

identify included libraries in `clang llvm` install:
- "this command lists all the available LLVM libraries, including C++ and object-oriented interface (OOI) libraries":

```bash
llvm-config --libs

>_ -lLLVM-17
```

- identify libs in `/usr/local/lib`
- "look for `.a` (static libraries) or `.dylib` (dynamic libraries) prefixed with `libclan`g or `libLLVM`. These files represent the available libraries."
  
```bash
ls

>_ cmake
docker
dtrace
engines-3
gettext
libasprintf.0.dylib
libasprintf.a
libasprintf.dylib
libbinaryen.dylib
libbrotlicommon.1.1.0.dylib
libbrotlicommon.1.dylib
libbrotlicommon.dylib
libbrotlidec.1.1.0.dylib
libbrotlidec.1.dylib
libbrotlidec.dylib
libbrotlienc.1.1.0.dylib
libbrotlienc.1.dylib
libbrotlienc.dylib
libcares.2.11.0.dylib
libcares.2.dylib
libcares.dylib
libcares_static.a
libcrypto.3.dylib
libcrypto.a
libcrypto.dylib
libev.4.dylib
libev.a
libev.dylib
libgettextlib-0.21.dylib
libgettextlib.dylib
libgettextpo.0.dylib
libgettextpo.a
libgettextpo.dylib
libgettextsrc-0.21.dylib
libgettextsrc.dylib
libidn2.0.dylib
libidn2.a
libidn2.dylib
libintl.8.dylib
libintl.a
libintl.dylib
libjemalloc.2.dylib
libjemalloc.a
libjemalloc.dylib
libjemalloc_pic.a
liblz4.1.9.4.dylib
liblz4.1.dylib
liblz4.a
liblz4.dylib
liblzma.5.dylib
liblzma.a
liblzma.dylib
libmpdec++.4.0.0.dylib
libmpdec++.4.dylib
libmpdec++.a
libmpdec++.dylib
libmpdec.4.0.0.dylib
libmpdec.4.dylib
libmpdec.a
libmpdec.dylib
libnghttp2.14.dylib
libnghttp2.a
libnghttp2.dylib
libpcre2-16.0.dylib
libpcre2-16.a
libpcre2-16.dylib
libpcre2-32.0.dylib
libpcre2-32.a
libpcre2-32.dylib
libpcre2-8.0.dylib
libpcre2-8.a
libpcre2-8.dylib
libpcre2-posix.3.dylib
libpcre2-posix.a
libpcre2-posix.dylib
libssl.3.dylib
libssl.a
libssl.dylib
libtextstyle.0.dylib
libtextstyle.a
libtextstyle.dylib
libunistring.2.dylib
libunistring.a
libunistring.dylib
libuv.1.dylib
libuv.a
libuv.dylib
libz3.4.12.5.0.dylib
libz3.4.12.dylib
libz3.dylib
libzstd.1.5.5.dylib
libzstd.1.dylib
libzstd.a
libzstd.dylib
node_modules
ossl-modules
pkgconfig
python3.12
```


- locating a specific library (the one from my `make` error):

```bash
locate libLLVMBitWriter

>_ WARNING: The locate database (/var/db/locate.database) does not exist.
To create the database, run the following command:

  sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

Please be aware that the database can take some time to generate; once
the database has been created, this message will no longer appear.
```

- ^it's a database??? what is an LLVM lib database??? (#todo)
- "If the library isn't in a standard path, provide its location: CMake: Use `target_link_directories` or set `CMAKE_LIBRARY_PATH`.
- (copying from above) 
  - "CMake should locate the library automatically if it's installed in a standard location. If not, you might need to specify the path to the library using `find_library` or similar commands.
  - Compiling manually: Use the appropriate compiler flags to link against the library. For example, with the Clang compiler, you'd use the `-lLLVMBitWriter` flag."
- "Header path: Ensure the path to LLVM headers is included in your compiler's search paths. Use compiler flags like `-I/path/to/llvm/include`."
- don't forget [LLVM docs](https://llvm.org/docs/)


# next day (thurs feb 29, 2024)

- prev missing header error: "configure your compiler to include the LLVM header directory during compilation. You can do this by setting the `includePath` in your makefile or using compiler flags like `-I/path/to/include` (replace `/path/to/include` with the actual LLVM `include` directory)."
- i think path to the header is `/usr/local/opt/llvm/include/llvm`

- testing again:

```bash
~/dev/ModuleMakerTest ± ● main
❯ make
-- Could NOT find FFI (missing: FFI_LIBRARIES HAVE_FFI_CALL) 
-- Could NOT find LibEdit (missing: LibEdit_INCLUDE_DIRS LibEdit_LIBRARIES) 
-- Could NOT find Terminfo (missing: Terminfo_LIBRARIES Terminfo_LINKABLE) 
-- Could NOT find ZLIB (missing: ZLIB_LIBRARY ZLIB_INCLUDE_DIR) 
-- Could NOT find zstd (missing: zstd_LIBRARY zstd_INCLUDE_DIR) 
-- Could NOT find LibXml2 (missing: LIBXML2_LIBRARY LIBXML2_INCLUDE_DIR) 
CMake Warning (dev) at /usr/local/opt/llvm/lib/cmake/llvm/LLVMExports.cmake:1339 (add_library):
  ADD_LIBRARY called with SHARED option but the target platform does not
  support dynamic linking.  Building a STATIC library instead.  This may lead
  to problems.
Call Stack (most recent call first):
  /usr/local/opt/llvm/lib/cmake/llvm/LLVMConfig.cmake:345 (include)
  /usr/local/opt/llvm/lib/cmake/clang/ClangConfig.cmake:10 (find_package)
  CMakeLists.txt:2 (find_package)
This warning is for project developers.  Use -Wno-dev to suppress it.

CMake Warning (dev) at /usr/local/opt/llvm/lib/cmake/llvm/LLVMExports.cmake:1586 (add_library):
  ADD_LIBRARY called with SHARED option but the target platform does not
  support dynamic linking.  Building a STATIC library instead.  This may lead
  to problems.
Call Stack (most recent call first):
  /usr/local/opt/llvm/lib/cmake/llvm/LLVMConfig.cmake:345 (include)
  /usr/local/opt/llvm/lib/cmake/clang/ClangConfig.cmake:10 (find_package)
  CMakeLists.txt:2 (find_package)
This warning is for project developers.  Use -Wno-dev to suppress it.

CMake Warning (dev) at /usr/local/opt/llvm/lib/cmake/llvm/LLVMExports.cmake:1589 (add_library):
  ADD_LIBRARY called with SHARED option but the target platform does not
  support dynamic linking.  Building a STATIC library instead.  This may lead
  to problems.
Call Stack (most recent call first):
  /usr/local/opt/llvm/lib/cmake/llvm/LLVMConfig.cmake:345 (include)
  /usr/local/opt/llvm/lib/cmake/clang/ClangConfig.cmake:10 (find_package)
  CMakeLists.txt:2 (find_package)
This warning is for project developers.  Use -Wno-dev to suppress it.

CMake Warning (dev) at /usr/local/opt/llvm/lib/cmake/llvm/LLVMExports.cmake:1633 (add_library):
  ADD_LIBRARY called with SHARED option but the target platform does not
  support dynamic linking.  Building a STATIC library instead.  This may lead
  to problems.
Call Stack (most recent call first):
  /usr/local/opt/llvm/lib/cmake/llvm/LLVMConfig.cmake:345 (include)
  /usr/local/opt/llvm/lib/cmake/clang/ClangConfig.cmake:10 (find_package)
  CMakeLists.txt:2 (find_package)
This warning is for project developers.  Use -Wno-dev to suppress it.

CMake Warning (dev) at /usr/local/opt/llvm/lib/cmake/llvm/LLVMExports.cmake:1658 (add_library):
  ADD_LIBRARY called with MODULE option but the target platform does not
  support dynamic linking.  Building a STATIC library instead.  This may lead
  to problems.
Call Stack (most recent call first):
  /usr/local/opt/llvm/lib/cmake/llvm/LLVMConfig.cmake:345 (include)
  /usr/local/opt/llvm/lib/cmake/clang/ClangConfig.cmake:10 (find_package)
  CMakeLists.txt:2 (find_package)
This warning is for project developers.  Use -Wno-dev to suppress it.

CMake Warning (dev) at /usr/local/opt/llvm/lib/cmake/clang/ClangTargets.cmake:388 (add_library):
  ADD_LIBRARY called with SHARED option but the target platform does not
  support dynamic linking.  Building a STATIC library instead.  This may lead
  to problems.
Call Stack (most recent call first):
  /usr/local/opt/llvm/lib/cmake/clang/ClangConfig.cmake:19 (include)
  CMakeLists.txt:2 (find_package)
This warning is for project developers.  Use -Wno-dev to suppress it.

CMake Warning (dev) at /usr/local/opt/llvm/lib/cmake/clang/ClangTargets.cmake:762 (add_library):
  ADD_LIBRARY called with SHARED option but the target platform does not
  support dynamic linking.  Building a STATIC library instead.  This may lead
  to problems.
Call Stack (most recent call first):
  /usr/local/opt/llvm/lib/cmake/clang/ClangConfig.cmake:19 (include)
  CMakeLists.txt:2 (find_package)
This warning is for project developers.  Use -Wno-dev to suppress it.

CMake Warning (dev) at /usr/local/opt/llvm/lib/cmake/clang/ClangTargets.cmake:789 (add_library):
  ADD_LIBRARY called with SHARED option but the target platform does not
  support dynamic linking.  Building a STATIC library instead.  This may lead
  to problems.
Call Stack (most recent call first):
  /usr/local/opt/llvm/lib/cmake/clang/ClangConfig.cmake:19 (include)
  CMakeLists.txt:2 (find_package)
This warning is for project developers.  Use -Wno-dev to suppress it.

CMake Error at CMakeLists.txt:3 (target_link_libraries):
  Cannot specify link libraries for target "ModuleMakerTest" which is not
  built by this project.


CMake Warning (dev) in CMakeLists.txt:
  No cmake_minimum_required command is present.  A line of code such as

    cmake_minimum_required(VERSION 3.23)

  should be added at the top of the file.  The version specified may be lower
  if you wish to support older CMake versions for this project.  For more
  information run "cmake --help-policy CMP0000".
This warning is for project developers.  Use -Wno-dev to suppress it.

-- Configuring incomplete, errors occurred!
See also "/Users/ash/dev/ModuleMakerTest/CMakeFiles/CMakeOutput.log".
See also "/Users/ash/dev/ModuleMakerTest/CMakeFiles/CMakeError.log".
make: *** [cmake_check_build_system] Error 1


```


# next day (fri mar 1 2024)

- these are errors with `make`, the rest are warnings:

```bash
-- Could NOT find FFI (missing: FFI_LIBRARIES HAVE_FFI_CALL) 
-- Could NOT find LibEdit (missing: LibEdit_INCLUDE_DIRS LibEdit_LIBRARIES) 
-- Could NOT find Terminfo (missing: Terminfo_LIBRARIES Terminfo_LINKABLE) 
-- Could NOT find ZLIB (missing: ZLIB_LIBRARY ZLIB_INCLUDE_DIR) 
-- Could NOT find zstd (missing: zstd_LIBRARY zstd_INCLUDE_DIR) 
-- Could NOT find LibXml2 (missing: LIBXML2_LIBRARY LIBXML2_INCLUDE_DIR) 
```

- which kinds of libraries are they? how can i know? what are the diff file extensions would they have?
  - `FFI`: The message mentions `FFI_LIBRARIES`, suggesting the actual library name might be "`libffi`" (common on Linux/Unix) or have "`ffi`" in the name.
  - `LibEdit`: The message mentions `LibEdit_INCLUDE_DIRS` and `LibEdit_LIBRARIES`, indicating the library is likely named "`LibEdit`".
  - `Terminfo`: The message mentions `Terminfo_LIBRARIES` and `Terminfo_LINKABLE`, suggesting the actual library name might be "`terminfo`" (common on Linux/Unix) or have "`terminfo`" in the name.
  - Locate command (Linux/Unix): You can use the locate command to search for files based on patterns. Try commands like `locate libffi.so` or `locate libxml2.dylib` (replace with appropriate library names).
  - Search directories (macOS): Libraries are usually stored in specific directories. On macOS, look in `/usr/lib` and `/System/Library/Frameworks`.

1. `.so` (Shared Object):
Found on Linux and Unix-based systems like Ubuntu, Debian, etc.
Contains compiled code that can be shared and reused by multiple programs at runtime.
Similar to .dll (Dynamic Link Library) on Windows systems.

1. `.dylib` (Dynamic Library):
Found specifically on macOS and iOS.
Similar to .so but the file format is specific to Apple platforms.
Also allows sharing and reuse of compiled code at runtime.

1. `.framework` (Framework):
Found on macOS and iOS.
A bundle containing compiled code, resources, and metadata about a specific functionality.
Offers a higher level of organization and functionality compared to individual .so or .dylib files.

1. `.h` (Header):
Used on various platforms including Linux, macOS, Windows, etc..
Contains declarations of functions, variables, and data structures used in a program.
Not directly executable, but included by other source code files (e.g., .c or .cpp) to access the declared elements.


- which diff kinds of CMake commands are needed for diff lib types? what are the diff types of env variables that need to be set? where are they stored? what are they right now before trying to change them? how do i locate the the libs and env vars?
  - `find_package` command to search for specific libraries and set variables like `LIBRARY` and `INCLUDE_DIRS`
  - finding frameworks might involve using `find_framework` instead of the standard `find_package`
  - `target_link_libraries` command: This command links the target executable or library with the found libraries.
    - You might need to specify the full path to the library file (e.g., `/usr/lib/libz.dylib`) on macOS or just the library name (e.g., `ZLIB`) on Linux if the library is found in the standard search directories.


- try to locate them with `locate libffi.so`

```bash
locate libffi.so   
locate libffi.dylib
locate LibEdit.framework
locate terminfo
locate libz.dylib
locate zlib.h
locate libxml2.dylib
locate libxml2/libxml/xmlversion.h
```


# next day sat march 2, 2024

- try locating them:

```bash
locate libffi.so   

>_  WARNING: The locate database (/var/db/locate.database) does not exist.
To create the database, run the following command:

sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

locate libffi.so   

>_  WARNING: The locate database (/var/db/locate.database) does not exist.
To create the database, run the following command: 

""

```

- not sure how long it will take to start the database

`The -w flag waits for the process to finish before returning the prompt.`

`While the database is building, the terminal prompt won't be available. You can't enter any new commands.`

- ^this didnt happen.
- need another way to locate the files. i could just look for them or try to install locate again. 



# next day sun march 3, 2024

- tried this `locate libffi.so` and go no feedback in the terminal, which is great news, because i didn't get the error, so the previous day's commands worked

```bash
locate libffi.dylib
/Library/Ruby/Gems/2.6.0/gems/ffi-1.11.1/ext/ffi_c/libffi-x86_64/.libs/libffi.dylib

locate LibEdit.framework
>_ no feedback

locate terminfo
> hundreds of lines of feedback

locate libz.dylib
/Applications/Descript.app/Contents/Resources/app.asar.unpacked/node_modules/beamcoder/build/Release/libz.dylib

locate zlib.h
/Library/Developer/CommandLineTools/SDKs/MacOSX12.3.sdk/System/Library/Frameworks/Kernel.framework/Versions/A/Headers/libkern/zlib.h
/Library/Developer/CommandLineTools/SDKs/MacOSX12.3.sdk/usr/include/bzlib.h
/Library/Developer/CommandLineTools/SDKs/MacOSX12.3.sdk/usr/include/zlib.h
/Library/Developer/CommandLineTools/SDKs/MacOSX13.1.sdk/System/Library/Frameworks/Kernel.framework/Versions/A/Headers/libkern/zlib.h
/Library/Developer/CommandLineTools/SDKs/MacOSX13.1.sdk/usr/include/bzlib.h
/Library/Developer/CommandLineTools/SDKs/MacOSX13.1.sdk/usr/include/zlib.h
/Library/Developer/CommandLineTools/SDKs/MacOSX13.3.sdk/System/Library/Frameworks/Kernel.framework/Versions/A/Headers/libkern/zlib.h
/Library/Developer/CommandLineTools/SDKs/MacOSX13.3.sdk/usr/include/bzlib.h
/Library/Developer/CommandLineTools/SDKs/MacOSX13.3.sdk/usr/include/zlib.h
/Library/Developer/CommandLineTools/SDKs/MacOSX14.2.sdk/System/Library/Frameworks/Kernel.framework/Versions/A/Headers/libkern/zlib.h
/Library/Developer/CommandLineTools/SDKs/MacOSX14.2.sdk/usr/include/bzlib.h
/Library/Developer/CommandLineTools/SDKs/MacOSX14.2.sdk/usr/include/zlib.h
/Library/Frameworks/Python.framework/Versions/3.11/Resources/English.lproj/Documentation/library/zlib.html
/Users/ash/.cargo/registry/src/github.com-1ecc6299db9ec823/bzip2-sys-0.1.10+1.0.8/bzip2-1.0.8/bzlib.h
/Users/ash/.cargo/registry/src/github.com-1ecc6299db9ec823/bzip2-sys-0.1.11+1.0.8/bzip2-1.0.8/bzlib.h
/Users/ash/.cargo/registry/src/github.com-1ecc6299db9ec823/libgit2-sys-0.12.23+1.2.0/libgit2/deps/zlib/zlib.h
/Users/ash/.cargo/registry/src/github.com-1ecc6299db9ec823/libgit2-sys-0.12.26+1.3.0/libgit2/deps/zlib/zlib.h
/Users/ash/.cargo/registry/src/github.com-1ecc6299db9ec823/libgit2-sys-0.13.4+1.4.2/libgit2/deps/zlib/zlib.h
/Users/ash/.cargo/registry/src/github.com-1ecc6299db9ec823/librocksdb-sys-6.20.3/bzip2/bzlib.h
/Users/ash/.cargo/registry/src/github.com-1ecc6299db9ec823/librocksdb-sys-6.20.3/zlib/zlib.h
/Users/ash/.cargo/registry/src/github.com-1ecc6299db9ec823/libz-sys-1.1.2/src/zlib/zlib.h
/Users/ash/.cargo/registry/src/github.com-1ecc6299db9ec823/libz-sys-1.1.2/src/zlib-ng/zlib.h
/Users/ash/.cargo/registry/src/github.com-1ecc6299db9ec823/libz-sys-1.1.3/src/zlib/zlib.h
/Users/ash/.cargo/registry/src/github.com-1ecc6299db9ec823/libz-sys-1.1.3/src/zlib-ng/zlib.h
/Users/ash/.cargo/registry/src/github.com-1ecc6299db9ec823/libz-sys-1.1.5/src/zlib/zlib.h
/Users/ash/.cargo/registry/src/github.com-1ecc6299db9ec823/libz-sys-1.1.5/src/zlib-ng/zlib.h.in
/Users/ash/.cargo/registry/src/github.com-1ecc6299db9ec823/libz-sys-1.1.8/src/zlib/zlib.h
/Users/ash/.cargo/registry/src/github.com-1ecc6299db9ec823/libz-sys-1.1.8/src/zlib-ng/zlib.h.in
/Users/ash/.node-gyp/14.2.0/include/node/zlib.h
/Users/ash/dev/CMake-fork/Utilities/cm3p/bzlib.h
/Users/ash/dev/CMake-fork/Utilities/cm3p/zlib.h
/Users/ash/dev/CMake-fork/Utilities/cmbzip2/bzlib.h
/Users/ash/dev/CMake-fork/Utilities/cmzlib/zlib.h
/Users/ash/dev/llvm-project/clang/test/Driver/hip-offload-compress-zlib.hip
/usr/local/include/node/zlib.h

locate libxml2.dylib
>_ no feedback

locate libxml2/libxml/xmlversion.h
>_ no feedback
```

- results:
  - `terminfo` is installed in a ton of places (need to find the right one and make it priority) but will be hard to search
  - `zlib.h` looks like its installed in rustc dirs before CMake and llvm local repos last, so that one looks really promising
  - the rest have no feedback or are in unexpected places, which makes me think they're probably wouldn't work.

next steps:
- i should look for some official clang/llvm local install instructions (without `homebrew`) with `apt-get` or something
- oh actually let me try `brew install llvm --devel`
  - worked some, then got the error `Error: invalid option: --devel`
  - "Some packages offer a separate formula for the development version. Search for formulas containing "dev" or "devel" in the name on https://formulae.brew.sh/."
  - "You can install the standard package and then manually install the development headers using the brew link --overwrite llvm command (replace llvm with the package name). This creates symbolic links in the standard locations for development tools to find them."
  - "Building LLVM from source code offers the most control over development libraries, but it's a more complex process. This approach is recommended for advanced users who have specific needs. Refer to the official LLVM getting started guide for detailed instructions: https://www.youtube.com/watch?v=gCLDuu36HHM"






# next day mon march 4, 2024

- align all of these:
  - installed llvm dev libraries
  - $PATH
  - cmake config

```bash
❯ brew install llvm
==> Downloading https://formulae.brew.sh/api/formula.jws.js
#################################################### 100.0%
==> Downloading https://formulae.brew.sh/api/cask.jws.json
#################################################### 100.0%
Warning: llvm 17.0.6_1 is already installed and up-to-date.
To reinstall 17.0.6_1, run:
  brew reinstall llvm
```


```bash
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
Required: python@3.12 ✘, z3 ✘, zstd ✔
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
install: 44,707 (30 days), 145,108 (90 days), 470,071 (365 days)
install-on-request: 19,652 (30 days), 63,470 (90 days), 309,979 (365 days)
build-error: 498 (30 days)
```

results:
- looks like i don't have all the dependencies, and some i do have but not installed in the right place
- do i need to use `libc++`? probably.
- `not symlinked into /usr/local` so okay then i really probably shouldnt use homebrew unless i shouldnt add dev libraries to my system's clang/llvm
- now have a command for setting the `$PATH` 
  - make sure `zshrc` is the shell i'm using (note: it's in the `~` dir)
  - These environment variable changes only apply to the current terminal session. To make them permanent, add the export lines to your shell configuration file (e.g., `.bashrc` or `.zshrc`).
- `which clang` to check the exact location and modify the path accordingly
- now have commands to set compilers to find llvm
- "Consider using a tool like `cmake-find-modules` to automate environment variable configuration during project builds."
- read fully through this which i haven't yet: [official llvm advanced config options](https://llvm.org/docs/)

```bash
==> Dependencies
Build: cmake ✘, ninja ✘, swig ✘
Required: python@3.12 ✘, z3 ✘, zstd ✔

...


==> Caveats
To use the bundled libc++ please add the following LDFLAGS:
  LDFLAGS="-L/usr/local/opt/llvm/lib/c++ -Wl,-rpath,/usr/local/opt/llvm/lib/c++"

llvm is keg-only, which means it was not symlinked into /usr/local,
because macOS already provides this software and installing another version in
parallel can cause all kinds of trouble.

If you need to have llvm first in your PATH, run:
  echo 'export PATH="/usr/local/opt/llvm/bin:$PATH"' >> ~/.zshrc
  or 
  export PATH="/usr/local/opt/llvm/bin:$PATH"


For compilers to find llvm you may need to set:
  export LDFLAGS="-L/usr/local/opt/llvm/lib"
  export CPPFLAGS="-I/usr/local/opt/llvm/include"
```

### next steps:

- read fully: [official llvm 17.0 advanced config options](https://llvm.org/docs/GettingStarted.html) notes:


# tues mar 5, 2024

#### overview of article^

- `LLVM` is core: "contains all of the tools, libraries, and header files needed to process intermediate representations and converts it into object files. Tools include an assembler, disassembler, bitcode analyzer, and bitcode optimizer. It also contains basic regression tests."
- frontend: `clang` "This component compiles C, `C++`, Objective C, and Objective C++ code into LLVM bitcode – and from there into object files, using LLVM."
- "Other components include: the `libc++ C++ standard library`, the `LLD linker`, and more."

- uses the `git clone` installation
- uses `cmake` to configure
- `Visual Studio` is a build system generator

- `cmake -S llvm -B build -G <generator> [options]`
  - "For example, to build LLVM, Clang, and LLD, use `-DLLVM_ENABLE_PROJECTS="clang;lld"`."
  - `-DCMAKE_INSTALL_PREFIX=directory` — Specify for directory the full pathname of where you want the LLVM tools and libraries to be installed (default `/usr/local`).
  - etc.
- `cmake --build build [--target <target>]` or the build system specified above directly.
  - The default target (i.e. `cmake --build build` or `make -C build`) will build all of LLVM.
  - CMake will generate build targets for each tool and library, and most LLVM sub-projects generate their own `check-<project>` target.
- A basic CMake and build/test invocation which only builds LLVM and no other subprojects. This will setup an LLVM build with debugging info, then compile LLVM and run LLVM tests.
  - `cmake -S llvm -B build -G Ninja -DCMAKE_BUILD_TYPE=Debug`
  - `ninja -C build check-llvm`

- etc.
  - [more cmake info](https://llvm.org/docs/CMake.html)

- minimum versions:

```
Clang 5.0
Apple Clang 10.0
GCC 7.4
Visual Studio 2019 16.7
```

next steps:
- what is the "default target" and should i use it?
- what are "build targets" for each tool and library?
- do i need LLVM sub-projects?


 # next day - wed mar 6, 2024

 - the default target in `cmake` is "`make`" but users can specify a different target with the `--build` option
 - A build target in CMake is a specific file or directory that CMake creates when you build your project. These targets are created based on the instructions you provide CMake through `CMakeLists.txt` files. There are different types of build targets, including executables, libraries, and documentation. By default, CMake will generate makefiles that will build these targets. However, you can also specify a different build tool using the `-G` option
 - This document discusses building LLVM with CMake. It covers various options and variables you can set. Some of the sub-projects you can enable are `clang`, `lldb`, `libc++`, and `libcxxabi`. You can also specify which runtimes to build.


- try this simple example from that doc: https://llvm.org/docs/GettingStarted.html#simple-example


```c
#include <stdio.h>

int main() {
  printf("hello world\n");
  return 0;
}
```


```bash
clang hello.c -o hello
clang -O3 -emit-llvm hello.c -c -o hello.bc
./hello
lli hello.bc

llvm-dis < hello.bc | less

; ModuleID = '<stdin>'
source_filename = "hello.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx14.0.0"

@str = private unnamed_addr constant [12 x i8] c"hello world\00", align 1

; Function Attrs: nofree nounwind ssp uwtable
define i32 @main() local_unnamed_addr #0 {
  %1 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str)
  ret i32 0
}

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #1

attributes #0 = { nofree nounwind ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cmov,+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 2}
!3 = !{i32 7, !"frame-pointer", i32 2}
!4 = !{!"Homebrew clang version 17.0.6"}


llc hello.bc -o hello.s

gcc hello.s -o hello.native                             

./hello.native

```

results:
- everything worked, which means i finally built and ran with clang and llvm for the first time. 
- note: it didn't use a cmake config.

next steps:
- study each step of the execution
  - build target files
  - bash flags
  - source files
  - location of all files
  - clang config


# thurs mar 7, 2024

- yikes i'm having a tough time with this
- the llvm docs example seems to need Xcode
- the CMake official docs dont have an example for macOS
- i think i need to continue the Cmake tutorial. already done the first step, but think i'll need to try to customize it. here: https://cmake.org/cmake/help/latest/guide/tutorial/Adding%20a%20Library.html
- research how Cmake works with macOS