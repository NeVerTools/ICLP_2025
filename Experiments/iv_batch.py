import sys

sys.path.insert(0, 'IntervalVerifier')
from core.model import IntervalModel

verified = {
    3: [],
    4: [],
    5: [],
    6: []
}
unsafe = {
    3: [],
    4: [],
    5: [],
    6: []
}

with open('instances_1.csv', 'r') as inst:
    for line in inst:
        f_net, f_prop, _ = line.strip('\n').split(',')

        model_3 = IntervalModel(f_net, 6)

        for i, m in enumerate([model_3]):
            result = m.verify(f_prop)

            if result:
                verified[6].append(f_prop)
            else:
                unsafe[6].append(f_prop)

for i in [6]:
    print(f'p = {i}')
    print(f'# Verified         : {len(verified[i])}')
    print(f'# Unsafe or unknown: {len(unsafe[i])}')