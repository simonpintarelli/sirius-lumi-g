
_spack_view=$(realpath $(dirname ${BASH_SOURCE[0]}))/.spack-env/view
echo "spack_view: ${_spack_view}"
export LD_LIBRARY_PATH=${_spack_view}/lib64:${_spack_view}/lib:${LD_LIBRARY_PATH}
