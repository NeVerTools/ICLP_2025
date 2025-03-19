#!/bin/bash

# Usage: ./test_intver.sh <model_file> <property_file> <precision>

MODEL=$1
PROPERTY=$2
PRECISION=$3

conda activate iclp_iv
python IntervalVerifier/verifier.py "$MODEL" "$PROPERTY" --precision "$PRECISION"
conda deactivate