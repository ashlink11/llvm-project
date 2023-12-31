//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// <string>

// int compare(const basic_string_view sv) const // constexpr since C++20

#include <string>
#include <cassert>

#include "test_macros.h"
#include "min_allocator.h"

TEST_CONSTEXPR_CXX20 int sign(int x) {
  if (x == 0)
    return 0;
  if (x < 0)
    return -1;
  return 1;
}

template <class S, class SV>
TEST_CONSTEXPR_CXX20 void test(const S& s, SV sv, int x) {
  LIBCPP_ASSERT_NOEXCEPT(s.compare(sv));
  assert(sign(s.compare(sv)) == sign(x));
}

template <class CharT, template <class> class Alloc>
TEST_CONSTEXPR_CXX20 void test_string() {
  using S  = std::basic_string<CharT, std::char_traits<CharT>, Alloc<CharT> >;
  using SV = std::basic_string_view<CharT, std::char_traits<CharT> >;

  test(S(""), SV(""), 0);
  test(S(""), SV("abcde"), -5);
  test(S(""), SV("abcdefghij"), -10);
  test(S(""), SV("abcdefghijklmnopqrst"), -20);
  test(S("abcde"), SV(""), 5);
  test(S("abcde"), SV("abcde"), 0);
  test(S("abcde"), SV("abcdefghij"), -5);
  test(S("abcde"), SV("abcdefghijklmnopqrst"), -15);
  test(S("abcdefghij"), SV(""), 10);
  test(S("abcdefghij"), SV("abcde"), 5);
  test(S("abcdefghij"), SV("abcdefghij"), 0);
  test(S("abcdefghij"), SV("abcdefghijklmnopqrst"), -10);
  test(S("abcdefghijklmnopqrst"), SV(""), 20);
  test(S("abcdefghijklmnopqrst"), SV("abcde"), 15);
  test(S("abcdefghijklmnopqrst"), SV("abcdefghij"), 10);
  test(S("abcdefghijklmnopqrst"), SV("abcdefghijklmnopqrst"), 0);
}

TEST_CONSTEXPR_CXX20 bool test() {
  test_string<char, std::allocator>();
#if TEST_STD_VER >= 11
  test_string<char, min_allocator>();
#endif

  return true;
}

int main(int, char**) {
  test();
#if TEST_STD_VER > 17
  static_assert(test());
#endif

  return 0;
}
