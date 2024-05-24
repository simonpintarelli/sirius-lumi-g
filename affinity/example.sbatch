#!/bin/bash
#SBATCH --no-requeue
#SBATCH --get-user-env
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --ntasks-per-node=16
#SBATCH --time=00:30:00
#SBATCH --gres=gpu:8
#SBATCH --mem=0
#SBATCH --account=<...>
#SBATCH --partition=dev-g

export OMP_PLACES=threads
export OMP_PROC_BIND=close
export MPICH_GPU_SUPPORT_ENABLED=1

# this exports $CPU_BIND and$OMP_NUM_THREADS given ntasks-per-node
source ./binding_vars.sh

# Assuming sirius.json exists already, otherwise set the evp solver manually
# jq '. | .control.std_evp_solver_name="magma_gpu" | .control.gen_evp_solver_name="lapack") > sirius.json

srun -u --cpu-bind=${CPU_BIND},verbose ./select_gpu.sh sirius.scf
