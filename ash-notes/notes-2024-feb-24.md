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



### next steps:
- make sure I dont have `XCode` still installed from old macOS versions
- explore LLVM compiler browser envs too
- check `homebrew clang` and `git clone` are the same version
- continue with `homebrew` method
- continue with `git clone` method 