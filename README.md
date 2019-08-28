# CMake toolchain files for Caanoo development

This repository contains CMake toolchain files to help with C/C++ development for the Caannoo console.

## Setup instructions

Download the Caanoo SDK and extract the archive on your local machine.
The SDK for Linux can be downloaded [here](https://dl.openhandhelds.org/cgi-bin/caanoo.cgi?0,1,0,0,17,631).

Once extracted, all the SDK files will be located under a directory named `GPH_SDK`.
Create a new `cmake` directory under `GPH_SDK` and copy the `caanoo.cmake` and `FindDGE.cmake` files there.

Edit your `.bashrc` file in order to define the `CAANOO_ROOT` environment variable to your SDK path.
For example:

```bash
export CAANOO_ROOT=$HOME/GPH_SDK
```

To make things even easier, you can also define an alias in your `.bashrc` file that will simplify the call to CMake with the appropriate arguments.
For example:

```bash
alias cmake-caanoo="cmake -DCMAKE_TOOLCHAIN_FILE=$CAANOO_ROOT/cmake/caanoo.cmake"
```
