#!/bin/bash

./Launchers/abcrown.sh
./Launchers/pyrat.sh
./Launchers/marabou.sh
./Launchers/never2.sh

conda activate ifm_base
python show_vulnerability.py
conda deactivate
