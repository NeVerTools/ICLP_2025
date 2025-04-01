#!/bin/bash

# Run all MATLAB scripts to create the benchmarks
matlab -batch "MATLAB/Binary_L/main0; MATLAB/Binary_L/main1"
matlab -batch "MATLAB/Multi_L/main0; MATLAB/Multi_L/main1"
matlab -batch "MATLAB/Binary_NL/main0; MATLAB/Binary_NL/main1"
matlab -batch "MATLAB/Multi_NL/main0; MATLAB/Multi_NL/main1"

# All files created, generate the networks and properties
# The attack precision is fixed in the MATLAB scripts, it
# must be changed inside them
conda activate iclp_base
python generate_benchmark.py
conda deactivates