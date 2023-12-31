//===-- Definition of ENTRY type ------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef __LLVM_LIBC_TYPES_ENTRY_H__
#define __LLVM_LIBC_TYPES_ENTRY_H__

typedef struct {
  char *key;
  void *data;
} ENTRY;

#endif // __LLVM_LIBC_TYPES_ENTRY_H__
