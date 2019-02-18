# Flibcpp example app

Example standalone application that uses Flibcpp (and nothing else, not even a
C++ compiler). To test:

1. Download and install [Flibcpp](https://github.com/swig-fortran/flibcpp)
2. Clone this repository; `git clone https://github.com/swig-fortran/flibcpp-example-app`
3. Create a build directory and execute `cmake $PATH_TO_EXAMPLE_SOURCE`. If
   your installation location for `Flibcpp` is nonstandard, you'll probably
   want to include it in your `CMAKE_PREFIX_PATH` environment variable before
   running CMake.
4. Build and run: `make && ./example`
   
