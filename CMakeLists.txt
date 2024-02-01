cmake_minimum_required(VERSION 3.23.3)
project(llvm-project)

set(LLVM_LINK_COMPONENTS
  BitWriter
  Core
  Support
  )

  add_llvm_example(ModuleMaker
  ModuleMaker.cpp
  )