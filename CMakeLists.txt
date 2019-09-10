#---------------------------------------------------------------------------#
# \file CMakeLists.txt
#
# Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
# Distributed under an MIT open source license: see LICENSE for details.
#---------------------------------------------------------------------------#

cmake_minimum_required(VERSION 3.9)
project(FlibcppExample VERSION 0.1.0 LANGUAGES Fortran)

#---------------------------------------------------------------------------#
# OPTIONS
#---------------------------------------------------------------------------#

if (NOT DEFINED(CMAKE_INSTALL_RPATH_USE_LINK_PATH))
  set(CMAKE_INSTALL_RPATH_USE_LINK_PATH ON CACHE STRING
      "Inform installed binaries of linked library rpaths")
endif()

#---------------------------------------------------------------------------#
# DEPENDENCIES
#---------------------------------------------------------------------------#

# Use the 'FlibcppConfig.cmake' file installed by flibcpp
find_package(Flibcpp REQUIRED CONFIG)

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

#---------------------------------------------------------------------------#
# APP
#---------------------------------------------------------------------------#
include(GNUInstallDirs)

add_executable(example app/example.f90)
target_link_libraries(example example_backend)

install(TARGETS example
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

