#!/bin/bash

# Usage: ./test_intver.sh <model_type> <precision>
# <model_type> is either 0 (binary linear) or 1 (multi linear)

MODEL=$1
PRECISION=$2

conda activate ifm_iv
python launch_iv.py "$MODEL" "$PRECISION"
conda deactivate
