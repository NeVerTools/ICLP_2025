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

        model_3 = IntervalModel(f_net)
        model_4 = IntervalModel(f_net, 4)
        model_5 = IntervalModel(f_net, 5)
        model_6 = IntervalModel(f_net, 6)

        for i, m in enumerate([model_3, model_4, model_5, model_6]):
            result = m.verify(f_prop)

            if result:
                verified[i + 3].append(f_prop)
            else:
                unsafe[i + 3].append(f_prop)

for i in range(3, 7):
    print(f'p = {i}')
    print(f'# Verified         : {len(verified[i])}')
    print(f'# Unsafe or unknown: {len(unsafe[i])}')
