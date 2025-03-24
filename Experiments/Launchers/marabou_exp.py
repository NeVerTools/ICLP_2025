from maraboupy import Marabou

verified = []
unsafe = []

with open('../instances_3.csv', 'r') as inst:
    for line in inst:
        f_net, f_prop, _ = line.strip('\n').split(',')

        net = Marabou.read_onnx(f'../{f_net}')
        result = net.solve(propertyFilename=f'../{f_prop}', options=Marabou.createOptions(timeoutInSeconds=60, verbosity=0))

        if result[0] == 'unsat':
            verified.append(f_prop)
        else:
            unsafe.append(f_prop)

print(f'Verified: {verified}')
print(f'Unsafe or unknown: {unsafe}')
