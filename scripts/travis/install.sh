#!/bin/sh -e
###############################################################################
# File  : scripts/travis/install.sh
#
# Install dependencies.
###############################################################################

set -x

mkdir -p ${INSTALL_ROOT}/bin

if [ "${GENERATOR}" = "Ninja" ]; then
  # Install Ninja-fortran
  cd $(mktemp -d)
  NINJA_VERSION=1.9.0.g99df1.kitware.dyndep-1.jobserver-1
  curl -L https://github.com/Kitware/ninja/releases/download/v${NINJA_VERSION}/ninja-${NINJA_VERSION}_x86_64-linux-gnu.tar.gz \
    | tar -xz --strip 1
  mv ninja ${INSTALL_ROOT}/bin
  echo "Installed Ninja version: $(ninja --version | head -1)"
fi

echo "Fortran compiler version: $(${FC} --version | head -1)"
echo "CMake version: $(cmake --version)"

if [ "${BUILTIN_FLIBCPP}" = "OFF" ]; then
  # Install master version of flibcpp
  cd $(mktemp -d)
  git clone https://github.com/swig-fortran/flibcpp
  cd flibcpp
  echo "flibcpp git revision: $(git rev-parse HEAD)"
  mkdir build && cd build
  cmake -G "${GENERATOR}" \
    -DBUILD_SHARED_LIBS=${SHARED} \
    -DCMAKE_INSTALL_PREFIX=${INSTALL_ROOT} \
    ..
  cmake --build . --target install --parallel
fi

###############################################################################
# end of scripts/travis/install.sh
###############################################################################
