#!/bin/bash

conda activate pyrat
python execute_pyrat.py ../instances_0.csv
python execute_pyrat.py ../instances_1.csv
python execute_pyrat.py ../instances_2.csv
python execute_pyrat.py ../instances_3.csv
conda deactivate