#!/bin/sh -e
###############################################################################
# File  : scripts/travis/configure.sh
###############################################################################

CXX_FLAGS="-Wall -Wextra -Werror"
Fortran_FLAGS="-Wall -Wextra -Wimplicit-procedure -Wimplicit-interface -Wno-compare-reals -Wno-maybe-uninitialized"

set -x
cd ${BUILD_ROOT} && cmake -G "${GENERATOR}" \
  -DBUILD_SHARED_LIBS="${SHARED}" \
  -DBUILTIN_FLIBCPP="${BUILTIN_FLIBCPP}" \
  -DCMAKE_CXX_FLAGS="${CXX_FLAGS}" \
  -DCMAKE_Fortran_FLAGS="${Fortran_FLAGS}" \
  -DCMAKE_INSTALL_PREFIX="${INSTALL_ROOT}" \
  ${SOURCE_ROOT}

###############################################################################
# end of scripts/travis/configure.sh
###############################################################################
