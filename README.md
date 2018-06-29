# tensorflow-cmake

## Introduction

Example of compiling and linking tensorflow as a static library to a Windows c++ program using cmake

## Instructions

From a windows command line run the following command:

``` batch
build_solution.cmd
```

This batch file will perform the following tasks:

1. Download cmake if required
2. Clone the tensorflow repository
3. Open an x64 Native Tools Command Prompt for VS2017
4. Build tensorflow static libraries optimized for Intel AVX2
5. Build and link the example c++ solution

## References

The following resources were used in developing this project:

Usage | Link
--- | ---
Instructions to compile tensorflow as a static library  | [Building a static Tensorflow C++ library on Windows](https://joe-antognini.github.io/machine-learning/build-windows-tf)
Instructions on linking tensorflow static library to a Windows program  | [Building a standalone C++ Tensorflow program on Windows](https://joe-antognini.github.io/machine-learning/build-windows-tf)
Instructions on building tensorflow optimized for Intel® Advanced Vector Extensions 2 (AVX2)  | [Explore Unity Technologies ML-Agents* Exclusively on Intel® Architecture](https://software.intel.com/en-us/articles/explore-unity-technologies-ml-agents-exclusively-on-intel-architecture)