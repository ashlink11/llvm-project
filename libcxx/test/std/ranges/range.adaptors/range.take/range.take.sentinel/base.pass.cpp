//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// UNSUPPORTED: c++03, c++11, c++14, c++17

// constexpr sentinel_t<Base> base() const;

#include <ranges>
#include <cassert>

#include "test_macros.h"
#include "test_iterators.h"
#include "../types.h"

constexpr bool test() {
  int buffer[8] = {1, 2, 3, 4, 5, 6, 7, 8};
  {
    std::ranges::take_view<MoveOnlyView> tv(MoveOnlyView(buffer), 4);
    std::same_as<sentinel_wrapper<int*>> auto sw1 = tv.end().base();
    assert(base(sw1) == buffer + 8);
    std::same_as<sentinel_wrapper<int*>> auto sw2 = std::as_const(tv).end().base();
    assert(base(sw2) == buffer + 8);
  }
  return true;
}

int main(int, char**) {
  test();
  static_assert(test());

  return 0;
}
