#!/bin/bash

set -e

mkdir -p $ROCM_BUILD_DIR/hipcc
cd $ROCM_BUILD_DIR/hipcc
pushd .


START_TIME=`date +%s`

cmake \
    -DHIP_COMMON_DIR="$HIP_DIR" \
    -DAMD_OPENCL_PATH="$OPENCL_DIR" \
    -DROCCLR_PATH="$ROCCLR_DIR" \
    -DCMAKE_PREFIX_PATH="$ROCM_INSTALL_DIR" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCPACK_GENERATOR=DEB \
    -DROCM_PATCH_VERSION=50100 \
    -DCMAKE_INSTALL_PREFIX=$ROCM_BUILD_DIR/hipcc/install \
    -G Ninja \
    ${ROCM_GIT_DIR}/llvm-project/amd/hipcc

cmake --build .
cmake --build . --target package

popd



mkdir -p $ROCM_BUILD_DIR/hip
cd $ROCM_BUILD_DIR/hip
pushd .

ROCclr_DIR=$ROCM_GIT_DIR/ROCclr
OPENCL_DIR=$ROCM_GIT_DIR/ROCm-OpenCL-Runtime
HIP_DIR=$ROCM_GIT_DIR/HIP

START_TIME=`date +%s`

cmake \
    -DHIP_COMMON_DIR="$HIP_DIR" \
    -DAMD_OPENCL_PATH="$OPENCL_DIR" \
    -DROCCLR_PATH="$ROCCLR_DIR" \
    -DCMAKE_PREFIX_PATH="$ROCM_INSTALL_DIR" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCPACK_GENERATOR=DEB \
    -DROCM_PATCH_VERSION=50100 \
    -DCLR_BUILD_HIP=ON \
    -DCLR_BUILD_OCL=OFF \
    -DCMAKE_INSTALL_PREFIX=$ROCM_BUILD_DIR/hip/install \
    -DHIPCC_BIN_DIR=$ROCM_BUILD_DIR/hipcc \
    -G Ninja \
    $ROCM_GIT_DIR/clr 

    #-DOFFLOAD_ARCH_STR="--offload-arch=$AMDGPU_TARGETS" \

cmake --build .
cmake --build . --target package
sudo dpkg -i hip-dev*.deb hip-doc*.deb hip-runtime-amd*.deb

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

