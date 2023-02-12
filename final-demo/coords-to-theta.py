from math import atan
from sys import argv


def coords_to_theta(alpha, beta):
    return 2 * atan(beta / alpha)


if len(argv) != 2:
    print('usage: python3 coords-to-theta.py coords.txt')
    quit()

with open(argv[1], 'r', encoding='utf-8') as f:
    lines = f.readlines()

for line in lines:
    line = line.split('\n')[0]
    print(line.split(' ')[0][0], end=' ')
    line = line.split(' ')[1]
    alpha = float(line.split(',')[0][1:])
    beta = float(line.split(',')[1][:-1])
    print(coords_to_theta(alpha, beta))
