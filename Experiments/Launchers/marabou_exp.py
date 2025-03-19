from maraboupy import Marabou

with open('../instances.csv', 'r') as inst:
    for line in inst:
        f_net, f_prop, _ = line.strip('\n').split(',')

        net = Marabou.read_onnx(f'../{f_net}')
        net.solve(propertyFilename=f'../{f_prop}')