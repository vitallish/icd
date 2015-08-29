#!/bin/sh
docker run --rm -ti -v $(pwd):/mnt  rocker/r-base sh -c "apt-get update && apt-get install --yes --fix-missing littler r-cran-xml libxml2-dev/unstable libcurl4-gnutls-dev && /usr/share/doc/littler/examples/check.r --setwd /mnt --install-deps $1"
