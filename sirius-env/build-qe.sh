#!/usr/bin/bash

# git clone https://github.com/electronic-structure/q-e-sirius.git

# export CMAKE_PREFIX_PATHS for dependencies of q-e-sirius (sirius) installed via spack
# spack -e . load --sh sirius > sirius.load.sh
#

(
set -eu

module purge

source ./sirius.load.sh

rm -rf qe-build


#module load LUMI/22.08
#module load PrgEnv-gnu
#module load cray-mpich/8.1.23
#module load gcc/11.2.0
#module unload cray-libsci
#module load craype-x86-trento
#module unload craype-accel-amd-gfx90a
#
#module list


export PATH=/opt/cray/pe/gcc/11.2.0/bin:$PATH


#export PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:/opt/cray/xpmem/2.5.2-2.4_3.20__gd0f7936.shasta/lib64/pkgconfig
export PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:/opt/cray/xpmem/2.5.2-2.4_3.47__gd0f7936.shasta/lib64/pkgconfig
export CMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}:/opt/rocm-5.2.3/rocsolver/lib/cmake 
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/scratch/project_465000416/sipintar/spack-install/22.08-ext-rocm/umpire-2022.03.1-nlbmi57/lib

FC=mpif90 CC=mpicc  CXX=mpic++ cmake --trace --debug-output -B qe-build \
      -DQE_ENABLE_SIRIUS=ON \
      -DQE_ENABLE_CUDA=OFF \
      -DQE_LAPACK_INTERNAL=OFF \
      -DQE_ENABLE_DOC=OFF \
      -DQE_ENABLE_MPI:BOOL=ON \
      -DQE_ENABLE_OPENMP:BOOL=ON \
      -DQE_ENABLE_ELPA:BOOL=OFF \
      -DQE_ENABLE_LIBXC:BOOL=OFF \
      -DQE_ENABLE_HDF5:BOOL=OFF \
      -DQE_ENABLE_SCALAPACK:BOOL=OFF \
      -DQE_ENABLE_TRACE:BOOL=OFF \
      -DQE_ENABLE_PTRACE:BOOL=OFF \
      -DCMAKE_INSTALL_PREFIX=./qe-bin \
      q-e-sirius

cmake  --build qe-build --parallel 12 -- VERBOSE=1
cmake --install qe-build
) | tee qe-build.log
