# SONIC workflows
This repository serves to deploy and run SONIC workflows for performance tests at Purdue Hammer cluster.

## Setup
```bash
# Check github access and configure git info / SSH keys if necessary:
ssh -T git@github.com

# Download the setup script
wget https://raw.githubusercontent.com/kondratyevd/sonic-workflows/master/setup.sh
chmod +x setup.sh

# If running at Purdue Analysis Facility instead of Hammer cluster, open setup.sh and change ARCH to el8_amd64_gcc10

# Run the setup script
./setup.sh

source /cvmfs/cms.cern.ch/cmsset_default.sh
cd CMSSW_12_5_0_pre4/src/sonic-workflows
cmsenv

# Temporary fix to enable VOMS proxy 
source  /cvmfs/oasis.opensciencegrid.org/osg-software/osg-wn-client/3.6/current/el7-x86_64/setup.sh
voms-proxy-init --voms cms
```

## Running
```bash
# with GPUs:
cmsRun run.py maxEvents=1000 threads=4

# without GPUs:
cmsRun run.py maxEvents=1000 threads=4 device="cpu"
```
