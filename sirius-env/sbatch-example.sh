#!/bin/bash
#SBATCH --no-requeue
#SBATCH --job-name="sirius-test"
#SBATCH --get-user-env
#SBATCH --output=_scheduler-stdout.txt
#SBATCH --error=_scheduler-stderr.txt
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --ntasks-per-node=32
#SBATCH --time=00:30:00
#SBATCH --gres=gpu:8
#SBATCH --mem=0
#SBATCH --account=project_465000416
#SBATCH --partition=dev-g


export OMP_PLACES=threads
export OMP_PROC_BIND=close

# this exports $CPU_BIND and $OMP_NUM_THREADS given ntasks-per-node
source /path/to/sirius-env/binding_vars.sh

select_gpu=path/to/sirius-env/select_gpu.sh

# wrapper around pw.x, automatically sets the LD_LIBRARY_PATH
pwx=/path/to/pw.x

# set eigenvalue solver for sirius
(echo "{}" | jq '.control.std_evp_solver_name="magma_gpu" | .control.gen_evp_solver_name="lapack" | .control.verbosity=2') > sirius.json


SIRIUS_PRINT_TIMING=1 srun -u --cpu-bind=${CPU_BIND},verbose $select_gpu $pwx -in pw.in > pw.out
