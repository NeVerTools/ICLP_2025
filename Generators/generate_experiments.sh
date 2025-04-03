#!/bin/bash

# Run all MATLAB scripts to create the benchmarks
matlab -nodisplay -r "run('MATLAB/Binary_L/main0.m');run('MATLAB/Binary_L/main1.m');exit"
matlab -nodisplay -r "run('MATLAB/Multi_L/main0.m');run('MATLAB/Multi_L/main1.m');exit"
matlab -nodisplay -r "run('MATLAB/Binary_NL/main0.m');run('MATLAB/Binary_NL/main1.m');exit"
matlab -nodisplay -r "run('MATLAB/Multi_NL/main0.m');run('MATLAB/Multi_NL/main1.m');exit"

# All files created, generate the networks and properties
# The attack precision is fixed in the MATLAB scripts, it
# must be changed inside them
conda activate iclp_base
python generate_benchmark.py
conda deactivates