# SONIC workflows
This repository serves to deploy and run SONIC workflows for performance tests at Purdue Hammer cluster.

## Setup
```bash
wget https://raw.githubusercontent.com/kondratyevd/sonic-workflows/master/setup.sh
chmod +x setup.sh
./setup.sh

cd CMSSW_12_5_0_pre4/src/sonic-workflows
cmsenv

voms-proxy-init --voms cms
```

## Running
```bash
# with GPUs:
cmsRun run.py maxEvents=1000 threads=4

# without GPUs:
cmsRun run.py maxEvents=1000 threads=4 device="cpu"
```
