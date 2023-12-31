//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// UNSUPPORTED: c++03, c++11, c++14
// TODO: Change to XFAIL once https://github.com/llvm/llvm-project/issues/40340 is fixed
// UNSUPPORTED: availability-pmr-missing

// <string>

// namespace std::pmr {
// template <class Char, class Traits = ...>
// using basic_string =
//     ::std::basic_string<Char, Traits, polymorphic_allocator<Char>>
//
// typedef ... string
// typedef ... u16string
// typedef ... u32string
// typedef ... wstring
//
// } // namespace std::pmr

#include <string>
#include <cassert>
#include <memory_resource>
#include <type_traits>

#include "constexpr_char_traits.h"
#include "test_macros.h"

template <class Char, class PmrTypedef>
void test_string_typedef() {
  using StdStr = std::basic_string<Char, std::char_traits<Char>, std::pmr::polymorphic_allocator<Char>>;
  using PmrStr = std::pmr::basic_string<Char>;
  static_assert(std::is_same<StdStr, PmrStr>::value, "");
  static_assert(std::is_same<PmrStr, PmrTypedef>::value, "");
}

template <class Char, class Traits>
void test_basic_string_alias() {
  using StdStr = std::basic_string<Char, Traits, std::pmr::polymorphic_allocator<Char>>;
  using PmrStr = std::pmr::basic_string<Char, Traits>;
  static_assert(std::is_same<StdStr, PmrStr>::value, "");
}

int main(int, char**) {
  {
    test_string_typedef<char, std::pmr::string>();
#ifndef TEST_HAS_NO_WIDE_CHARACTERS
    test_string_typedef<wchar_t, std::pmr::wstring>();
#endif
    test_string_typedef<char16_t, std::pmr::u16string>();
    test_string_typedef<char32_t, std::pmr::u32string>();
  }
  {
    test_basic_string_alias<char, constexpr_char_traits<char>>();
#ifndef TEST_HAS_NO_WIDE_CHARACTERS
    test_basic_string_alias<wchar_t, constexpr_char_traits<wchar_t>>();
#endif
    test_basic_string_alias<char16_t, constexpr_char_traits<char16_t>>();
    test_basic_string_alias<char32_t, constexpr_char_traits<char32_t>>();
  }
  {
    // Check that std::basic_string has been included and is complete.
    std::pmr::string s;
    assert(s.get_allocator().resource() == std::pmr::get_default_resource());
  }

  return 0;
}
