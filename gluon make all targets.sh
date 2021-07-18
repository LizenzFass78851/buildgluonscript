#!/bin/bash

# Build all targets as of v2021.1 gluon, also broken and use all cpu cores (broken and cpu cores can be set in the script)
# If there were changes to the targets during gluon, this can also be set in the script

CPUCORES="8"
BROKENS="1"

TARGETS="ar71xx-generic
ar71xx-tiny
ar71xx-nand
ath79-generic
brcm2708-bcm2708
brcm2708-bcm2709
ipq40xx-generic
ipq806x-generic
lantiq-xrx200
lantiq-xway
mpc85xx-generic
mpc85xx-p1020
ramips-mt7620
ramips-mt7621
ramips-mt76x8
ramips-rt305x
sunxi-cortexa7
x86-generic
x86-geode
x86-legacy
x86-64"

for TARG in ${TARGETS}; do
	make GLUON_TARGET=$TARG BROKEB=$BROKENS -j$CPUCORES
done
