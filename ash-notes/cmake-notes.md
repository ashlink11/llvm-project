# CMake progress:

## code

```cpp
// A simple program that computes the square root of a number
#include <cmath>
#include <iostream>
#include <string>

int main(int argc, char* argv[])
{
  if (argc < 2) {
    std::cout << "Usage: " << argv[0] << " number" << std::endl;
    return 1;
  }

  // convert input to double
  const double inputValue = std::stod(argv[1]);

  // calculate square root
  const double outputValue = sqrt(inputValue);
  std::cout << "The square root of " << inputValue << " is " << outputValue
            << std::endl;
  return 0;
}
```


## config 

```
cmake_minimum_required(VERSION 3.10)
project(Tutorial)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)
add_executable(Tutorial tutorial.cxx)
```


## commands

```bash
git clone https://github.com/ashlink11/CMake-fork.git

cd Help/guide/tutorial/

mkdir Step1_build // empty

cd Step1_build

cmake ../Step1
-- Configuring done
-- Generating done

cmake --build .
[ 50%] Building CXX object CMakeFiles/Tutorial.dir/tutorial.cxx.o
[100%] Linking CXX executable Tutorial
[100%] Built target Tutorial

./Tutorial 10
The square root of 10 is 3.16228
```


