import sys

import numpy as np
from pynever.networks import SequentialNetwork
from pynever.nodes import FullyConnectedNode, ReLUNode
from pynever.strategies.conversion.converters.onnx import ONNXConverter


def load_weights(m: int, p: int) -> list:
    """
    Load the weights from files.
    The files are of the form w_<model>_<precision>.csv for linear models
    and fc1/2_<model>_<precision>.csv for deep models.

    """

    if m < 2:
        with open(f'Data/w_{m}_{p}.csv', 'r') as w_f:
            lines = w_f.readlines()
            return [np.array([l.strip('\n').split(',') for l in lines], dtype=float)]
    else:
        with open(f'Data/fc1_{m}_{p}.csv', 'r') as fc1, open(f'Data/fc2_{m}_{p}.csv', 'r') as fc2:
            lines1 = fc1.readlines()
            lines2 = fc2.readlines()
            weights1 = np.array([l.strip('\n').split(',') for l in lines1], dtype=float)
            weights2 = np.array([l.strip('\n').split(',') for l in lines2], dtype=float)
            return [weights1, weights2]


def main(model: int, precision: int):
    """
    Script to recreate the benchmarks in the Experiments package

    :param model: the model to load (0: binary linear, 1: multiclass linear, 2: binary deep, 3: multiclass deep)
    :param precision: the precision of the model (only 2 and 4 available)
    """

    assert model in [0, 1, 2, 3] and precision in [2, 4], "Incorrect arguments, please read documentation"

    # Open weights
    weights = load_weights(model, precision)

    # Create network
    ntype = 'bin' if model % 2 == 0 else 'multi'
    arch = 'lin' if model < 2 else 'deep'
    net_name = f'mnist_{ntype}_{arch}_{precision}'

    nn = SequentialNetwork(net_name, 'X')

    f = 1 if model % 2 == 0 else 10
    if len(weights) == 1:
        nn.append_node(FullyConnectedNode('fc1', (784,), f, weights[0], has_bias=False))
    else:
        nn.append_node(FullyConnectedNode('fc1', (784,), 1000, weights[0], has_bias=False))
        nn.append_node(ReLUNode('rl1', (1000,)))
        nn.append_node(FullyConnectedNode('fc2', (1000,), f, weights[1], has_bias=False))

    # Save network
    ONNXConverter().from_neural_network(nn).save(f'../Experiments/Networks/{net_name}.onnx')

    # Open corresponding xv
    with open(f'Data/xv_{model}_{precision}.csv', 'r') as xv_f:
        lines = xv_f.readlines()
        xv = np.array([l.strip('\n').split(',') for l in lines], dtype=float)

    # Create property
    eps = 10 ** -precision
    with open(f'Data/yt_{model}_{precision}.csv', 'r') as lab:
        l = int(lab.read())

    with open(f'../Experiments/Properties/prop_{ntype}_{arch}_{precision}_label_{l}.vnnlib', 'w') as p:
        # Variables
        for i in range(xv.shape[0]):
            p.write(f'(declare-const X_{i} Real)\n')
        p.write('\n')
        for i in range(0 if ntype == 'bin' else 10):
            p.write(f'(declare-const Y_{i} Real)\n\n')

        # Constraints on X
        for i in range(xv.shape[0]):
            p.write(f'(assert (>= X_{i} {round((xv[i, 0] - eps) * 10 ** precision) / 10 ** precision}))\n')
            p.write(f'(assert (<= X_{i} {round((xv[i, 0] + eps) * 10 ** precision) / 10 ** precision}))\n')
        p.write('\n')

        # Constraints on Y
        if ntype == 'bin':
            if l == 1:
                p.write('(assert (or\n\t(and (<= Y_0 0.0))\n))')
            else:
                p.write('(assert (or\n\t(and (>= Y_0 0.0))\n))')
        else:
            p.write('(assert (or\n')
            for i in range(10):
                if i != l:
                    p.write(f'\t(and (<= Y_{l} Y_{i}))\n')
            p.write('))')


if __name__ == '__main__':
    try:
        main(int(sys.argv[1]), int(sys.argv[2]))
    except Exception as e:
        print(e)
        print('Usage: python generate_benchmark.py <model number> <precision> (read comments)')
