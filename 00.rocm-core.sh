#!/bin/bash

set -e

mkdir -p $ROCM_BUILD_DIR/rocm-core
cd $ROCM_BUILD_DIR/rocm-core
pushd .

START_TIME=`date +%s`

cmake \
  -DCMAKE_INSTALL_PREFIX=${ROCM_INSTALL_DIR} \
  -DROCM_VERSION=${ROCM_VERSION} \
  -DCPACK_GENERATOR=DEB \
  -DCMAKE_VERBOSE_MAKEFILE=1 \
  -DCPACK_DEBIAN_PACKAGE_RELEASE=${CPACK_DEBIAN_PACKAGE_RELEASE} \
  $ROCM_BUILD_DIR/../rocm_repo/rocm-core

cmake --build . --target package
sudo dpkg -i *.deb

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

