import os
import shutil

import numpy as np
from pynever.networks import SequentialNetwork
from pynever.nodes import FullyConnectedNode, ReLUNode
from pynever.strategies.conversion.converters.onnx import ONNXConverter


def load_weights(mpath: str, i: int, m: int, p: int) -> list:
    """
    Load the weights from files.
    The files are of the form w_<index>_<model>_<precision>.csv for linear models
    and fc1/2_<index>_<model>_<precision>.csv for deep models.

    """

    if m < 2:
        with open(f'Data/weights/{mpath}/w_{i}_{m}_{p}.csv', 'r') as w_f:
            lines = w_f.readlines()
            return [np.array([l.strip('\n').split(',') for l in lines], dtype=float)]
    else:
        with (open(f'Data/weights/{mpath}/fc1_{i}_{m}_{p}.csv', 'r') as fc1,
              open(f'Data/weights/{mpath}/fc2_{i}_{m}_{p}.csv', 'r') as fc2):
            lines1 = fc1.readlines()
            lines2 = fc2.readlines()
            weights1 = np.array([l.strip('\n').split(',') for l in lines1], dtype=float)
            weights2 = np.array([l.strip('\n').split(',') for l in lines2], dtype=float)
            return [weights1, weights2]


def main(mpath: str, index: int, model: int, precision: int):
    """
    Script to recreate the benchmarks in the Experiments package

    :param index: the example to consider
    :param model: the model to load (0: binary linear, 1: multiclass linear,
                                     2: binary nonlinear, 3: multiclass nonlinear)
    :param precision: the precision of the model
    """

    assert model in [0, 1, 2, 3], "Incorrect arguments, please read documentation"

    # Open weights
    weights = load_weights(mpath, index, model, precision)

    # Create network
    ntype = 'bin' if model % 2 == 0 else 'multi'
    arch = 'l' if model < 2 else 'nl'
    net_name = f'mnist_{index}_{ntype}_{arch}_{precision}'

    nn = SequentialNetwork(net_name, 'X')

    outs = 1 if model % 2 == 0 else 10
    if len(weights) == 1:
        nn.append_node(FullyConnectedNode('fc1', (784,), outs, weights[0], np.zeros(outs)))
    else:
        nn.append_node(FullyConnectedNode('fc1', (784,), 1000, weights[0], np.zeros(1000)))
        nn.append_node(ReLUNode('rl1', (1000,)))
        nn.append_node(FullyConnectedNode('fc2', (1000,), outs, weights[1], np.zeros(outs)))

    # Save network
    ONNXConverter().from_neural_network(nn).save(f'../Experiments/Networks/{net_name}.onnx')

    # Open corresponding xv
    with open(f'Data/points/{mpath}/xv_{index}_{model}_{precision}.csv', 'r') as xv_f:
        lines = xv_f.readlines()
        xv = np.array([l.strip('\n').split(',') for l in lines], dtype=float)

    # Create property
    eps = 10 ** -precision
    with open(f'Data/labels/{mpath}/yt_{index}_{model}_{precision}.csv', 'r') as lab:
        l = int(lab.read())
        if l == -1:
            l = 0

    with open(f'../Experiments/Properties/prop_{index}_{ntype}_{arch}_{precision}_label_{l}.vnnlib', 'w') as p:
        # Variables
        for i in range(xv.shape[0]):
            p.write(f'(declare-const X_{i} Real)\n')
        p.write('\n')
        for i in range(1 if ntype == 'bin' else 10):
            p.write(f'(declare-const Y_{i} Real)\n\n')

        # Constraints on X (preserving rounding)
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
        for m in ['Binary_L', 'Multi_L', 'Binary_NL', 'Multi_NL']:
            for p in os.listdir(f'Data/labels/{m}'):
                tokens = p.replace('yt_', '').replace('.csv', '').split('_')
                sample = int(tokens[0])
                model = int(tokens[1])
                precision = int(tokens[2])

                main(m, sample, model, precision)

                fname = f'xv_{sample}_{model}_{precision}.csv'
                shutil.copyfile(f'Data/points/{m}/{fname}', f'../Experiments/Vulnerability/{fname}')

    except Exception as e:
        print(e)
        print('Usage: python generate_benchmark.py <sample index> <model number> <precision> (read comments)')
