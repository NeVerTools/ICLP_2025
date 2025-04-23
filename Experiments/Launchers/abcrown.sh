#!/bin/bash

conda activate alpha-beta-crown
python ../../../alpha-beta-CROWN/complete_verifier/abcrown.py --config abcrown_config_0.yml
python ../../../alpha-beta-CROWN/complete_verifier/abcrown.py --config abcrown_config_1.yml
python ../../../alpha-beta-CROWN/complete_verifier/abcrown.py --config abcrown_config_2.yml
python ../../../alpha-beta-CROWN/complete_verifier/abcrown.py --config abcrown_config_3.yml
conda deactivate