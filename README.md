# Generation and Mitigation of Precision-Based Evasion Attacks in Neural Network Verification

### Stefano Demarchi, Luca Oneto, Davide Anguita and Armando Tacchella
### Submitted for publication in _iFM_ 2025

---
## Installation and setup


Clone this repository using the _recursive_ option
```bash
git clone --recursive https://github.com/nevertools/iFM_2025.git
```

To reproduce the experiments presented in the paper you will need to use different tools with little compatibility
between each other, so you will need to create the following environments (examples are in conda):

### 1. _Benchmark generation_

To recreate the benchmarks presented in the paper you will need MATLAB and Python 3.11.
The same environment will be used for verification with _*NeVer2*_ and _*Marabou*_.

You can get MATLAB academic licenses [here](https://www.mathworks.com/pricing-licensing.html?prodcode=ML&intendeduse=edu)
and create the Python environment with the following commands (assuming _[conda](https://anaconda.org/anaconda/conda)_
is installed):

```bash
conda create -n ifm_base python=3.11
conda activate ifm_base

pip install pynever maraboupy
conda deactivate
```

### 2. _Benchmark verification_

To test the benchmarks with verification tools you will both need to get the sources and create the corresponding
environments. The scripts in the [Experiments](Experiments) directory assume that the verifier sources are in the same root directory
of this repository.

- _*alpha-beta-CROWN*_

```bash
# Get the sources in the same root
cd ..
git clone --recursive https://github.com/Verified-Intelligence/alpha-beta-CROWN.git

cd alpha-beta-CROWN
conda env create -f complete_verifier/environment.yaml --name alpha-beta-crown
```
- _*pyRAT*_

```bash
# Get the sources in the same root
cd ..
git clone https://git.frama-c.com/pub/pyrat.git

cd pyrat
conda env create -f pyrat_env.yml
```

- _*NeVer2*_
```bash
# Get the sources in the same root
cd ..
git clone https://github.com/NeverTools/pyNever.git
```

### 3. _Mitigation_

To test the mitigation using intervals you will need the interval-based verifier in this repository, and the last
required environment:
```bash
conda create -n ifm_iv python=3.7
conda activate ifm_iv

pip install pyinterval
conda deactivate
```

---
## Usage

This repository contains all the code to reproduce the experiments of the paper. First you will generate the attacks,
then you will perform verification on the instances.

### 1. _Benchmarks generation_

The vulnerable points that are unsafe under a low-precision implementation are obtained with the MATLAB
scripts in the [MATLAB](Generators/MATLAB) directory. A Python script builds the ONNX networks and VNNLIB
specifications after the MATLAB scripts saved their data. The bash script [generate_experiments.sh](Generators/generate_experiments.sh)
runs all the code necessary[^1].

### 2. _Experimental evaluation_

The evaluation of the verification tools on the benchmarks is possible with the bash script
[test_verifies.sh](Experiments/test_verifiers.sh). For linear models, the preliminary version of
the interval-based verifier that mitigates the attack can be called with the [test_intver.sh](Experiments/test_intver.sh)
script.

[^1]: Please note that all bash scripts will likely fail due to [this issue](https://github.com/conda/conda/issues/7980)
that doesn't allow to run `conda activate` in bash scripts.
