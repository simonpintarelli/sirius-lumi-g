# export ROCR_VISIBLE_DEVICES_MAP and CPU_BIND

set -u

CPU_BIND8="mask_cpu:0xfe000000000000,0xfe00000000000000,0xfe0000,0xfe000000,0xfe,0xfe00,0xfe00000000,0xfe0000000000"
ROCR_VISIBLE_DEVICES_MAP8=(0 1 2 3 4 5 6 7)
nt8=7

CPU_BIND16="mask_cpu:0xe000000000000,0xe0000000000000,0xe00000000000000,0xe000000000000000,0xe0000,0xe00000,0xe000000,0xe0000000,0xe,0xe0,0xe00,0xe000,0xe00000000,0xe000000000,0xe0000000000,0xe00000000000"
# index by $SLURM_LOCALID
ROCR_VISIBLE_DEVICES_MAP16=(0 0 1 1 2 2 3 3 4 4 5 5 6 6 7 7)
nt16=3

CPU_BIND24="mask_cpu:0x6000000000000,0x18000000000000,0x60000000000000,0x600000000000000,0x1800000000000000,0x6000000000000000,0x60000,0x180000,0x600000,0x6000000,0x18000000,0x60000000,0x6,0x18,0x60,0x600,0x1800,0x6000,0x600000000,0x1800000000,0x6000000000,0x60000000000,0x180000000000,0x600000000000"
# index by $SLURM_LOCALID
ROCR_VISIBLE_DEVICES_MAP24=(0 0 0 1 1 1 2 2 2 3 3 3 4 4 4 5 5 5 6 6 6 7 7 7)
nt24=2

CPU_BIND32="mask_cpu:0x2000000000000,0x4000000000000,0x8000000000000,0x10000000000000,0x200000000000000,0x400000000000000,0x800000000000000,0x1000000000000000,0x20000,0x40000,0x80000,0x100000,0x2000000,0x4000000,0x8000000,0x10000000,0x2,0x4,0x8,0x10,0x200,0x400,0x800,0x1000,0x200000000,0x400000000,0x800000000,0x1000000000,0x20000000000,0x40000000000,0x80000000000,0x100000000000"
# index by $SLURM_LOCALID
ROCR_VISIBLE_DEVICES_MAP32=(0 0 0 0 1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4 5 5 5 5 6 6 6 6 7 7 7 7)
nt32=1

rocr_devices_varname="ROCR_VISIBLE_DEVICES_MAP${SLURM_TASKS_PER_NODE}"
cpu_bind_varname="CPU_BIND${SLURM_TASKS_PER_NODE}"

rocr_devices_varname="ROCR_VISIBLE_DEVICES_MAP${SLURM_TASKS_PER_NODE}[@]"
eval "ROCR_VISIBLE_DEVICES_MAP=(\${${rocr_devices_varname}})"
export ROCR_VISIBLE_DEVICES_MAP
nt_varname="nt${SLURM_TASKS_PER_NODE}"
export OMP_NUM_THREADS=${!nt_varname}

export CPU_BIND=${!cpu_bind_varname}
