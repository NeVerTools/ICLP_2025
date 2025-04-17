import os
import re

with open('instances_0.csv', 'w') as inst:
    for p in os.listdir('Properties'):
        core = p.replace('prop', '').split('_label')[0]
        if 'bin_l' in core:
            nname = f'Networks/mnist{core.replace(re.findall("_[0-9]+_", core)[0], "")}.onnx'
            inst.write(f'{nname},Properties/{p},300\n')

with open('instances_1.csv', 'w') as inst:
    for p in os.listdir('Properties'):
        core = p.replace('prop', '').split('_label')[0]
        if 'multi_l' in core:
            nname = f'Networks/mnist{core.replace(re.findall("_[0-9]+_", core)[0], "")}.onnx'
            inst.write(f'{nname},Properties/{p},300\n')

with open('instances_2.csv', 'w') as inst:
    for p in os.listdir('Properties'):
        core = p.replace('prop', '').split('_label')[0]
        if 'bin_nl' in core:
            nname = f'Networks/mnist{core.replace(re.findall("_[0-9]+_", core)[0], "")}.onnx'
            inst.write(f'{nname},Properties/{p},300\n')

with open('instances_3.csv', 'w') as inst:
    for p in os.listdir('Properties'):
        core = p.replace('prop', '').split('_label')[0]
        if 'multi_nl' in core:
            nname = f'Networks/mnist{core.replace(re.findall("_[0-9]+_", core)[0], "")}.onnx'
            inst.write(f'{nname},Properties/{p},300\n')
