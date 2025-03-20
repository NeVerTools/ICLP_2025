# Detection and Mitigation of Precision-Based Attacks in Neural Network Verification

---
# Installation and setup

Clone this repository using the _recursive_ option
```bash
git clone --recursive https://github.com/nevertools/ICLP_2025.git
```

To reproduce the experiments presented in the paper you will need to use different tools with little compatibility
between each other, so you will need to create the following environments (examples are in conda):

## 1. Benchmark generation

To recreate the benchmarks contained in the _Experiments_ directory you will need MATLAB and Python 3.11.
The same environment will be used for verification with _NeVer2_ and _Marabou_.

You can get MATLAB academic licenses [here](https://www.mathworks.com/pricing-licensing.html?prodcode=ML&intendeduse=edu)
and create the Python environment with the following commands (assuming _conda_ is installed):

```bash
conda create -n iclp_base python=3.11
conda activate iclp_base

pip install pynever maraboupy
conda deactivate
```

## 2. Benchmark verification

To test the benchmarks with verification tools you will both need to get the sources and create the corresponding
environments. The scripts in the _Experiments_ directory assume that the verifier sources are in the same root directory
of this repository.

- _*$\alpha$-$\beta$-CROWN*_

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

cd pyRAT
conda env create -f pyrat_env.yml
```

## 3. Mitigation

To test the mitigation using intervals you will need the interval-based verifier in this repository, and the last
required environment:
```bash
conda create -n iclp_iv python=3.7
conda activate iclp_iv

pip install pyinterval
conda deactivate
```
---
# Usage
