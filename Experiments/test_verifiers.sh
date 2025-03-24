#!/bin/bash

./Launchers/abcrown.sh
./Launchers/marabou.sh
./Launchers/pyrat.sh
./Launchers/never2.sh

conda activate iclp_base

python show_vulnerability.py 0 0 3
python show_vulnerability.py 0 1 3

conda deactivate