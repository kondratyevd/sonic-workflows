#!/bin/bash

ACCESS=ssh
CORES=8
BATCH=""

usage(){
	EXIT=$1

	echo "setup.sh [options]"
	echo ""
	echo "-B                  configure some settings for checkout within batch setups (default = ${BATCH})"
	echo "-a [protocol]       use protocol to clone (default = ${ACCESS}, alternative = https)"
	echo "-j [cores]          run CMSSW compilation on # cores (default = ${CORES})"
	echo "-h                  display this message and exit"

	exit $EXIT
}

# process options
while getopts "Ba:j:h" opt; do
	case "$opt" in
	B) BATCH=--upstream-only
	;;
	a) ACCESS=$OPTARG
	;;
	j) CORES=$OPTARG
	;;
	h) usage 0
	;;
	esac
done

# check options
if [ "$ACCESS" = "ssh" ]; then
	ACCESS_GITHUB=git@github.com:
	ACCESS_GITLAB=ssh://git@gitlab.cern.ch:7999/
	ACCESS_CMSSW=--ssh
elif [ "$ACCESS" = "https" ]; then
	ACCESS_GITHUB=https://github.com/
	ACCESS_GITLAB=https://gitlab.cern.ch/
	ACCESS_CMSSW=--https
else
	usage 1
fi

scram project CMSSW_12_0_0_pre4
cd CMSSW_12_0_0_pre4/src
eval `scramv1 runtime -sh`
git cms-init $ACCESS_CMSSW $BATCH
git cms-checkout-topic $ACCESS_CMSSW fastmachinelearning:CMSSW_12_0_0_pre4_SONIC
git cms-addpkg HeterogeneousCore/SonicTriton
git clone ${ACCESS_GITHUB}fastmachinelearning/sonic-models HeterogeneousCore/SonicTriton/data
git cms-addpkg RecoBTag/Combined
git clone ${ACCESS_GITHUB}fastmachinelearning/RecoBTag-Combined -b add_noragged RecoBTag/Combined/data
git clone ${ACCESS_GITHUB}fastmachinelearning/sonic-models
scram b -j ${CORES}