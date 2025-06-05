#!/bin/bash

conda activate ifm_base
python execute_marabou.py ../instances_0.csv
python execute_marabou.py ../instances_1.csv
python execute_marabou.py ../instances_2.csv
python execute_marabou.py ../instances_3.csv
conda deactivate
