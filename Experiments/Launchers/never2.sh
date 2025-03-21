#!/bin/bash

conda activate iclp_base
python ../../../pynever/never2_batch.py ../instances.csv ./ ssbp
conda deactivate