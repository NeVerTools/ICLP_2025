# Experiments analysis

---
In this directory you will find the necessary data to analyze the behaviour of verification tools
on the instances obtained in the [Experiments generation](../Generators/README.md) section.

This directory comprises:
* A set of ONNX neural networks in the [Networks](Networks) directory
* A set of VNNLIB properties in the [Properties](Properties) directory
* A set of verified, yet vulnerable points in the [Vulnerability](Vulnerability) directory
* A [CSV](instances.csv) file with the verification instances
* A [directory](Launchers) with scripts and additional data to execute the state of the art verifiers 
considered in the paper
* The reference to an [interval-based verifier](IntervalVerifier) that identifies the low-precision unsafety 

---
## Usage

The bash script `test_verifiers.sh` calls the scripts in the _Launchers_ directory and executes verification
with the corresponding tools. After that, it calls the `show_vulnerability.py` script to demonstrate the existence
of an adversary in the l-infinity norm considered safe by the verifiers.

The script `test_intver.sh` calls the interval-based verifier to show the successful mitigation of the attack.