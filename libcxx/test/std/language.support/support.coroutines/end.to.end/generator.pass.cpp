//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// UNSUPPORTED: c++03, c++11, c++14, c++17

// See https://llvm.org/PR33271
// UNSUPPORTED: ubsan

#include <coroutine>
#include <vector>
#include <cassert>

#include "test_macros.h"

template <typename Ty> struct generator {
  struct promise_type {
    Ty current_value;
    std::suspend_always yield_value(Ty value) {
      this->current_value = value;
      return {};
    }
    std::suspend_always initial_suspend() { return {}; }
    std::suspend_always final_suspend() noexcept { return {}; }
    generator get_return_object() { return generator{this}; };
    void return_void() {}
    void unhandled_exception() {}
  };

  struct iterator {
    std::coroutine_handle<promise_type> Coro_;
    bool Done_;

    iterator(std::coroutine_handle<promise_type> Coro, bool Done)
        : Coro_(Coro), Done_(Done) {}

    iterator &operator++() {
      Coro_.resume();
      Done_ = Coro_.done();
      return *this;
    }

    bool operator==(iterator const &_Right) const {
      return Done_ == _Right.Done_;
    }

    bool operator!=(iterator const &_Right) const { return !(*this == _Right); }

    Ty const &operator*() const { return Coro_.promise().current_value; }

    Ty const *operator->() const { return &(operator*()); }
  };

  iterator begin() {
    p.resume();
    return {p, p.done()};
  }

  iterator end() { return {p, true}; }

  generator(generator &&rhs) : p(rhs.p) { rhs.p = nullptr; }

  ~generator() {
    if (p)
      p.destroy();
  }

private:
  explicit generator(promise_type *promise)
      : p(std::coroutine_handle<promise_type>::from_promise(*promise)) {}

  std::coroutine_handle<promise_type> p;
};

struct minig {
  struct promise_type {
    int current_value;
    std::suspend_always yield_value(int value) {
      this->current_value = value;
      return {};
    }
    std::suspend_always initial_suspend() { return {}; }
    std::suspend_always final_suspend() noexcept { return {}; }
    minig get_return_object() { return minig{this}; };
    void return_void() {}
    void unhandled_exception() {}
  };

  bool move_next() {
    p.resume();
    return !p.done();
  }
  int current_value() { return p.promise().current_value; }

  minig(minig &&rhs) : p(rhs.p) { rhs.p = nullptr; }

  ~minig() {
    if (p)
      p.destroy();
  }

private:
  explicit minig(promise_type *promise)
      : p(std::coroutine_handle<promise_type>::from_promise(*promise)) {}

  std::coroutine_handle<promise_type> p;
};


minig mini_count(int n) {
  for (int i = 0; i < n; i++) {
    co_yield i;
  }
}

generator<int> count(int n) {
  for (int i = 0; i < n; ++i)
    co_yield i;
}

generator<int> range(int from, int n) {
  for (int i = from; i < n; ++i)
    co_yield i;
}

void test_count() {
  const std::vector<int> expect = {0, 1, 2, 3, 4};
  std::vector<int> got;
  for (auto x : count(5))
    got.push_back(x);
  assert(expect == got);
}

void test_range() {
  int sum = 0;
   for (auto v: range(1, 20))
      sum += v;
   assert(sum == 190);
}

void test_mini_generator() {
  int sum = 0;
  auto g = mini_count(5);
  while (g.move_next()) {
     sum += g.current_value();
  }
  assert(sum == 10);
}

int main(int, char**) {
  test_count();
  test_range();
  test_mini_generator();

  return 0;
}
