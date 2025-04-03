#!/bin/bash

conda activate iclp_base
python ../../../pynever/never2_batch.py -o output_0.csv ../instances_0.csv ./ ssbp
python ../../../pynever/never2_batch.py -o output_1.csv ../instances_1.csv ./ ssbp
python ../../../pynever/never2_batch.py -o output_2.csv ../instances_2.csv ./ ssbp
python ../../../pynever/never2_batch.py -o output_3.csv ../instances_3.csv ./ ssbp
conda deactivate