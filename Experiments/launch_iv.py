import sys

sys.path.insert(0, 'IntervalVerifier')
from core.model import IntervalModel

verified = []
unsafe = []

# 0, 1 for binary linear or multiclass linear
idx = sys.argv[1]

# Verification precision
p = int(sys.argv[2])

with open(f'instances_{idx}.csv', 'r') as inst:
    for line in inst:
        f_net, f_prop, _ = line.strip('\n').split(',')

        model = IntervalModel(f_net, p)

        if model.verify(f_prop):
            verified.append(f_prop)
        else:
            unsafe.append(f_prop)

print(f'p = {idx}')
print(f'# Verified  : {len(verified)}')
print(f'# Unsafe    : {len(unsafe)}')
