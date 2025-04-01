# Experiments generation

---
This directory contains the MATLAB scripts that train four different MNIST classifiers:
* 0 - [Binary Linear Classifier](MATLAB/Binary_L)
* 1 - [Multiclass Linear Classifier](MATLAB/Multi_L)
* 2 - [Binary Deep Classifier](MATLAB/Binary_NL)
* 3 - [Multiclass Deep Classifier](MATLAB/Multi_NL)

All the settings contain two files, `main0.m` and `main1.m`, that train the classifier and attack it,
respectively. Running both of them will result in finding a point close to the decision boundary such
that a low-precision implementation with _p_ digits will give an incorrect answer, and from this point
it is possible to compute an alleged provably robust sample.

The weights of the models, the vulnerable point to test and the correct label are exported by the `main1.m`
script in the [Data](Data) folder, so that the Python file `generate_benchmark.py` can build the ONNX and
VNNLIB models to test verifiers.
The vulnerable points are also saved in the [Vulnerability](../Experiments/Vulnerability) directory
to demonstrate their unsafety under a low-precision implementation.

---
## Usage

The bash script `generate_experiments.sh` executes MATLAB in the four settings and then calls the
Python script to build the benchmarks.
