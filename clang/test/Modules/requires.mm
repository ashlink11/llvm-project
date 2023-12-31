// RUN: rm -rf %t
// RUN: %clang_cc1 -Rmodule-include-translation -Wno-private-module -fmodules-cache-path=%t -fmodules -fimplicit-module-maps -F %S/Inputs -I %S/Inputs/DependsOnModule.framework %s -verify

@import DependsOnModule.CXX;
// expected-error@Modules/module.modulemap:11 {{module 'DependsOnModule.NotCXX' is incompatible with feature 'cplusplus'}}
@import DependsOnModule.NotCXX; // expected-note {{module imported here}}
// expected-error@Modules/module.modulemap:15 {{module 'DependsOnModule.NotObjC' is incompatible with feature 'objc'}}
@import DependsOnModule.NotObjC; // expected-note {{module imported here}}
