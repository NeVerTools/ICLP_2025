#!/bin/bash

# Run all MATLAB scripts to create the benchmarks
matlab -batch "MATLAB/BinaryLinear/main0; MATLAB/BinaryLinear/main1"
matlab -batch "MATLAB/MultiLinear/main0; MATLAB/MultiLinear/main1"
matlab -batch "MATLAB/BinaryDeep/main0; MATLAB/BinaryDeep/main1"
matlab -batch "MATLAB/MultiDeep/main0; MATLAB/MultiDeep/main1"

# All files created, generate the networks and properties
# The parameters are fixed in the MATLAB scripts, one can change
# the sample index and the precision inside
python generate_benchmark.py 0 0 3
python generate_benchmark.py 0 1 3
python generate_benchmark.py 1 2 3
python generate_benchmark.py 5 3 3