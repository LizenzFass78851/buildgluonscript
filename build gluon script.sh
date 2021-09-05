#!/bin/bash

# the script carries out the workflow to build gluon with the ffc site config
# All targets with all cpu cores are used when building and broken equals 1

BROKENS="1"

git clone --branch v2021.1.1 https://github.com/freifunk-gluon/gluon.git
cd gluon
git clone https://gitlab.com/FreifunkChemnitz/site-ffc.git site
make update
for target in $(make list-targets); do GLUON_TARGET=${target} make BROKEN=$BROKENS -j$(nproc||printf "2") download; done
for target in $(make list-targets); do GLUON_TARGET=${target} make BROKEN=$BROKENS -j$(nproc||printf "2"); done
