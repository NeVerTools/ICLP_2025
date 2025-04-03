import numpy as np
from matplotlib import pyplot as plt


def display(x: np.ndarray, filepath: str) -> None:
    pixels = x.reshape((28, 28))

    fig, ax = plt.subplots()
    img = ax.imshow(pixels, cmap='gray')
    plt.xticks([])
    plt.yticks([])

    ax.xaxis.set_major_locator(plt.NullLocator())
    ax.yaxis.set_major_locator(plt.NullLocator())

    plt.savefig(filepath, pad_inches = 0, bbox_inches='tight')

# BINARY LINEAR xv
with open(f'../Generators/MATLAB/Binary_L/bin_lin_xv.csv', 'r') as xv_f:
    lines = xv_f.readlines()
    x_v = np.array([l.strip('\n').split(',') for l in lines], dtype=float)
    display(x_v, 'xv_bl.pdf')

# BINARY LINEAR adv
with open(f'../Generators/MATLAB/Binary_L/bin_lin_adv.csv', 'r') as adv_f:
    lines = adv_f.readlines()
    x_v = np.array([l.strip('\n').split(',') for l in lines], dtype=float)
    display(x_v, 'adv_bl.pdf')

# MULTI LINEAR xv
with open(f'../Generators/MATLAB/Multi_L/multi_lin_xv.csv', 'r') as xv_f:
    lines = xv_f.readlines()
    x_v = np.array([l.strip('\n').split(',') for l in lines], dtype=float)
    display(x_v, 'xv_ml.pdf')

# MULTI LINEAR adv
with open(f'../Generators/MATLAB/Multi_L/multi_lin_adv.csv', 'r') as adv_f:
    lines = adv_f.readlines()
    x_v = np.array([l.strip('\n').split(',') for l in lines], dtype=float)
    display(x_v, 'adv_ml.pdf')

# BINARY NONLINEAR xv
with open(f'../Generators/MATLAB/Binary_NL/bin_nl_xv.csv', 'r') as xv_f:
    lines = xv_f.readlines()
    x_v = np.array([l.strip('\n').split(',') for l in lines], dtype=float)
    display(x_v, 'xv_bnl.pdf')

# BINARY NONLINEAR adv
with open(f'../Generators/MATLAB/Binary_NL/bin_nl_adv.csv', 'r') as adv_f:
    lines = adv_f.readlines()
    x_v = np.array([l.strip('\n').split(',') for l in lines], dtype=float)
    display(x_v, 'adv_bnl.pdf')

# MULTI NONLINEAR xv
with open(f'../Generators/MATLAB/Multi_NL/multi_nl_xv.csv', 'r') as xv_f:
    lines = xv_f.readlines()
    x_v = np.array([l.strip('\n').split(',') for l in lines], dtype=float)
    display(x_v, 'xv_mnl.pdf')

# MULTI NONLINEAR adv
with open(f'../Generators/MATLAB/Multi_NL/multi_nl_adv.csv', 'r') as adv_f:
    lines = adv_f.readlines()
    x_v = np.array([l.strip('\n').split(',') for l in lines], dtype=float)
    display(x_v, 'adv_mnl.pdf')