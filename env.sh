#!/bin/bash

dir_name=$(dirname $(readlink -f $0))
export ROCM_INSTALL_DIR=/opt/rocm
export ROCM_MAJOR_VERSION=6
export ROCM_MINOR_VERSION=1
export ROCM_PATCH_VERSION=1
export ROCM_LIBPATCH_VERSION=0
export ROCM_VERSION="${ROCM_MAJOR_VERSION}-${ROCM_MINOR_VERSION}-${ROCM_PATCH_VERSION}"
export CPACK_DEBIAN_PACKAGE_RELEASE=local.1024~24.04
export CPACK_GENERATOR=DEB
export ROCM_GIT_DIR=${dir_name}/src
export ROCM_BUILD_DIR=${dir_name}/build
export AMDGPU_TARGETS="gfx906"
export PATH=$ROCM_INSTALL_DIR/bin:$ROCM_INSTALL_DIR/llvm/bin:$ROCM_INSTALL_DIR/hip/bin:$CMAKE_DIR/bin:$PATH

