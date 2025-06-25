#!/bin/bash

set -euo pipefail

# TODO: change
QESIRIUS_DIR=/scratch/project_465001618/sipintar/q-e-sirius

# - make sirius available as dependency
# - load cray-mpich (installed via spack)
# - also provides dependencies for QE (HDF5, FFTW, openblas)
# it was generated using
# `spack -e ./sirius-env load --sh sirius > sirius-env/sirius.load`
source sirius-env/sirius.load
# also load cmake (system cmake is too old)
eval "$(spack -e sirius-env load --sh cmake)"
which cmake

FC=mpif90 CXX=mpic++ CC=mpicc \
          cmake \
          -DQE_ENABLE_MPI=On \
          -DQE_ENABLE_HDF5=On \
          -DQE_ENABLE_SIRIUS=On \
          -B $QESIRIUS_DIR/build \
          -S $QESIRIUS_DIR

cmake --build $QESIRIUS_DIR/build -j 8
