#---------------------------------------------------------------------------#
# \file CMakeLists.txt
#
# Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
# Distributed under an MIT open source license: see LICENSE for details.
#---------------------------------------------------------------------------#

cmake_minimum_required(VERSION 3.9)
project(FlibcppExampleApp VERSION 0.1.0 LANGUAGES Fortran)

include(GNUInstallDirs)

#---------------------------------------------------------------------------#
# OPTIONS
#---------------------------------------------------------------------------#

# Build static libs by default
option(BUILD_SHARED_LIBS "Build shared libraries" OFF)

# Use a local copy of Flibcpp rather than an external installation
option(BUILTIN_FLIBCPP
  "Download Git submodules during configuration"
  ON)

# Set up rpaths
if (NOT DEFINED CMAKE_INSTALL_RPATH_USE_LINK_PATH)
  set(CMAKE_INSTALL_RPATH_USE_LINK_PATH ON CACHE STRING
      "Inform installed binaries of external library rpaths")
endif()

if (BUILD_SHARED_LIBS)
  set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_FULL_LIBDIR}" CACHE STRING
      "Inform installed binaries of internal library rpaths")
endif()

#---------------------------------------------------------------------------#
# EXTERNAL DEPENDENCIES
#---------------------------------------------------------------------------#

if (BUILTIN_FLIBCPP)
  include(external/SubmoduleUtils.cmake)
  load_submodule(external/flibcpp)
  add_subdirectory(external/flibcpp)
  if (NOT BUILD_SHARED_LIBS)
    # The C++ runtime libraries are scoped to the subdirectory, and since we're
    # not using shared libs, they will not be linked into the example app.
    # Enable the CXX language in *this* scope to avoid link errors.
    enable_language(CXX)
  endif()
else()
  find_package(Flibcpp REQUIRED CONFIG)
endif()

#---------------------------------------------------------------------------#
# LIBRARY
#---------------------------------------------------------------------------#

set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/module)

add_library(example_backend
  "src/example_backend.f90")

# Use correct Fortran module directories
target_include_directories(example_backend
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
    PRIVATE
        $<BUILD_INTERFACE:${CMAKE_Fortran_MODULE_DIRECTORY}>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
)

# Link against Flibcpp libraries
target_link_libraries(example_backend Flibcpp::flc_random Flibcpp::flc_algorithm)

# Install
install(TARGETS example_backend
  LIBRARY DESTINATION	${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION	${CMAKE_INSTALL_LIBDIR}
)

#---------------------------------------------------------------------------#
# APP
#---------------------------------------------------------------------------#

add_executable(example app/example.f90)
target_link_libraries(example example_backend)

install(TARGETS example
  RUNTIME DESTINATION	${CMAKE_INSTALL_BINDIR}
)

