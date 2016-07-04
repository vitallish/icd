#!/bin/bash

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

pushd "$(mktemp -d)"
R CMD build ~/icd
ICD_SLOW_TESTS=TRUE R CMD check --as-cran "$(ls -t /tmp/icd*.tar.gz | head -1)"
popd
