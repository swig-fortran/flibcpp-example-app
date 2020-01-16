# Flibcpp example app

Example standalone application that uses Flibcpp (and nothing else, not even a
C++ compiler).

## Build with automatically downloaded flibcpp

1. Clone this repository: `git clone https://github.com/swig-fortran/flibcpp-example-app`
2. Create a build directory: `mkdir build && cd build`
3. Configure, build, and run: `cmake ../flibcpp-example-app && make &&
   ./example`

## Build with externally installed flibcpp

Clone this repository and create a build directory as above. Provide your
existing flibcpp's installation prefix to CMake using the `CMAKE_PREFIX_PATH`
environment variable, and disable the `BUILDIN_FLIBCPP` option on the
configuration line:
```console
$ CMAKE_PREFIX_PATH=/usr/local/myflibcpp \
> cmake -DBUILDIN_FLIBCPP=OFF ../flibcpp-example-app
```
Then make and run as before.
