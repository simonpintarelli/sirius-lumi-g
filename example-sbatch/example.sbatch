#!/bin/bash
#SBATCH --no-requeue
#SBATCH --get-user-env
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --ntasks-per-node=8
#SBATCH --time=00:30:00
#SBATCH --gres=gpu:8
#SBATCH --mem=0
#SBATCH --account=<...>
#SBATCH --partition=dev-g

set -u

export OMP_PLACES=threads
export OMP_PROC_BIND=close
export MPICH_GPU_SUPPORT_ENABLED=1

# this exports $CPU_BIND and$OMP_NUM_THREADS given ntasks-per-node
# --ntasks-per-node must be a multiple of 8 (8, 16, 32)
source ./binding_vars.sh

# set evp solver for sirius
jq '. | .control.std_evp_solver_name="magma_gpu" | .control.gen_evp_solver_name="lapack")' > sirius.json

# TODO change as needed
# this is the directory containing `sirius-env` and the QE-SIRIUS installation directory `qebin`
QE_ENV=../

SIRIUS_VIEW=${QE_ENV}/sirius-env/.spack-env/view
export LD_LIBRARY_PATH=$SIRIUS_VIEW/lib:$SIRIUS_VIEW/lib64
PATH=${QE_ENV}/qebin/bin:$PATH
export PATH

srun -u --cpu-bind=${CPU_BIND},verbose ./select_gpu.sh pw.x
