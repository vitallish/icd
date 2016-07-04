#!/bin/bash
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# if the second argument is missing, default to my development directory
ICD_HOME=${1:-$HOME/Documents/RProjects/icd}
pushd "$ICD_HOME"
R -d "valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all -v" -e "library(devtools); library(testthat); test()"

# other useful options: --instr-atstart=no
# then 'callgrind_control -i' or prograammatically start instrumentation

popd

