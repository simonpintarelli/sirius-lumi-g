#!/bin/bash -u

_dir=$(dirname "${BASH_SOURCE[0]}")

. $_dir/binding_vars.sh

export ROCR_VISIBLE_DEVICES=${ROCR_VISIBLE_DEVICES_MAP[$SLURM_LOCALID]}

exec $*
