#!/bin/bash

# Build all targets as of v2021.1 gluon, also broken and use all cpu cores (broken can be set in the script)
# If there were changes to the targets during gluon, this can also be set in the script


BROKENS="1"

# for gluon v2021.1.1
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

# for gluon current master from 17.04.2022
#-TARGETS="ath79-generic
#-ath79-nand
#-bcm27xx-bcm2708
#-bcm27xx-bcm2709
#-bcm27xx-bcm2710
#-ipq40xx-generic
#-ipq806x-generic
#-lantiq-xrx200
#-lantiq-xway
#-mediatek-mt7622
#-mpc85xx-p1010
#-mpc85xx-p1020
#-mvebu-cortexa9
#-ramips-mt76x8
#-ramips-mt7620
#-ramips-mt7621
#-rockchip-armv8
#-sunxi-cortexa7
#-x86-generic
#-x86-geode
#-x86-legacy
#-x86-64"


git clone --branch v2021.1.1 https://github.com/freifunk-gluon/gluon.git
cd gluon
git clone https://gitlab.com/FreifunkChemnitz/site-ffc.git site
make update


for TARG in ${TARGETS}; do
	echo downloading $TARG
	make GLUON_TARGET=$TARG BROKEN=$BROKENS -j$(nproc||printf "2") download
	RESULT=$?
	if [ $RESULT -ne 0 ]; then
		echo downloading $TARG failed;
		make GLUON_TARGET=$TARG BROKEN=$BROKENS V=s download
		RESULT=$?
		if [ $RESULT -ne 0 ]; then
			echo downloading $TARG failed again;
			exit 1;
		fi
	fi
done

for TARG in ${TARGETS}; do
	echo building $TARG
	make GLUON_TARGET=$TARG BROKEN=$BROKENS -j$(nproc||printf "2")
	RESULT=$?
	if [ $RESULT -ne 0 ]; then
		echo building $TARG failed;
		make GLUON_TARGET=$TARG BROKEN=$BROKENS V=s
		RESULT=$?
		if [ $RESULT -ne 0 ]; then
			echo building $TARG failed again;
			exit 1;
		fi
	fi
done
