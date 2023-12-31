// RUN: %clang_analyze_cc1 -Wno-implicit-function-declaration -Wno-implicit-int -w -verify %s \
// RUN:   -analyzer-checker=core \
// RUN:   -analyzer-checker=unix.StdCLibraryFunctions

// expected-no-diagnostics

typedef ssize_t;
b;

unsigned c;
int write(int, const void *, unsigned long);

a() {
  d();
  while (c > 0) {
    b = write(0, d, c);
    if (b)
      c -= b;
    b < 1;
  }
  if (c && c) {
    //     ^ no-crash
  }
}
