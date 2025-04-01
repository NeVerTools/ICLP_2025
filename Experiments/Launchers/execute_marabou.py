import sys

from maraboupy import Marabou

verified = []
unsafe = []
timeout = []

inst_f = sys.argv[1]

with open(f'{inst_f}', 'r') as inst:
    for line in inst:
        f_net, f_prop, _ = line.strip('\n').split(',')

        net = Marabou.read_onnx(f'../{f_net}')
        result = net.solve(propertyFilename=f'../{f_prop}',
                           options=Marabou.createOptions(timeoutInSeconds=60, verbosity=0))

        if result[0] == 'unsat':
            verified.append(f_prop)
        elif result[0] == 'sat':
            unsafe.append(f_prop)
        else:
            timeout.append(f_prop)

print(f'Verified : {len(verified)}')
print(f'Unsafe   : {len(unsafe)}')
print(f'Timeout  : {len(timeout)}')
