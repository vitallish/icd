#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# set environment here for slow and online tests
pushd "$(mktemp -d)"
R CMD build --no-build-vignettes ~/icd
ICD_SLOW_TESTS=FALSE R CMD check --no-build-vignettes --use-valgrind "$(ls -t /tmp/icd*.tar.gz | head -1)"
popd
