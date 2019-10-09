#-----------------------------------------------------------------------------#
# File  : flibcpp-example-app/cmake/SubmoduleUtils.cmake
#
# Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
# Distributed under an MIT open source license: see LICENSE for details.
#-----------------------------------------------------------------------------#

# Find git
find_package(Git)
if (NOT GIT_FOUND OR GIT_VERSION_STRING VERSION_LESS "1.5.3")
  # Git 1.5.3 is the earliest to support submodules.
  message(FATAL_ERROR "Git version 1.5.3 or higher must be available to use "
    "git submodules. ${_ERROR_MSG}")
endif()

function(load_submodule SUBDIR)
  if (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${SUBDIR}/CMakeLists.txt")
    set(_IS_GIT_SUBDIR TRUE)
  else()
    set(_IS_GIT_SUBDIR FALSE)
  endif()

  if (_IS_GIT_SUBDIR)
    message(STATUS
      "Git submodule \"${SUBDIR}\" is already checked out")
    return()
  endif()

  execute_process(
    COMMAND "${GIT_EXECUTABLE}" submodule update --init --recursive "${SUBDIR}"
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    OUTPUT_VARIABLE GIT_SUBMOD_MSG
    RESULT_VARIABLE GIT_SUBMOD_RESULT)
  if (GIT_SUBMOD_MSG)
    set(GIT_SUBMOD_MSG ":\n  ${GIT_SUBMOD_MSG}")
  endif()
  if (NOT GIT_SUBMOD_RESULT EQUAL "0")
    message(FATAL_ERROR "git submodule update --init ${SUBDIR} failed (error "
      "code ${GIT_SUBMOD_RESULT}${GIT_SUBMOD_MSG}); ${_ERROR_MSG}")
  else()
    message(STATUS
      "Successfully updated git submodule \"${SUBDIR}\"${GIT_SUBMOD_MSG}")
  endif()

  if (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${SUBDIR}/CMakeLists.txt")
    message(FATAL_ERROR "git submodule update --init failed to check out "
      "${SUBDIR}: ${_ERROR_MSG}")
  endif()
endfunction()


#-----------------------------------------------------------------------------#
# end of flibcpp-example-app/cmake/SubmoduleUtils.cmake
#-----------------------------------------------------------------------------#
