#!/usr/bin/env python3
import math, random
import matplotlib.pyplot as plt
# wow it's like many things i'm interested in are converging
# it's SO COOL
# math, linear algebra, radio, etc
# all of math is actually related sometimes
# like HOW THE HECK DO DOT PRODUCTS WORK ON FUNCTIONS --> INTEGRALS is so clever

# ok see https://www.desmos.com/calculator/wv3vlspin3 for my random thoughts

frequency = 1000 # Hz
mod_frequency = 100 # <= frequency
sampling_frequency = 100000

def sin_carrier(t):
    return math.sin(2 * math.pi * frequency * t)

def cos_carrier(t):
    return math.cos(2 * math.pi * frequency * t)

def noise(t):
    return random.random()

# let's try QPSK, encoding a signal on both sine and cosine

def dot_product(f1, f2, a, b, samples = 500):
    # ok so we basically want to take the integral from a to b of f1 * f2
    # (turning f1, f2 into vectors of infinite elements then multiplying corresponding components)
    # but we can't do that magically so we'll have to settle for Riemann sums
    total = 0
    for i in range(samples):
        x = a + i * ((b - a) / samples)
        total += f1(x) * f2(x)
    return total

# sin = I (in phase), cos = Q (in quadrature)
I = [1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1]
Q = [1, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 0]
assert len(I) == len(Q)

def modulation(t):
    # phase changes once every mod_period
    total = 0
    total += 0 * noise(t)
    total += 1 * sin_carrier(t) * I[int(math.floor(t * mod_frequency))]
    total += 1 * cos_carrier(t) * Q[int(math.floor(t * mod_frequency))]
    return total

# index / sampling_frequency = t
signal = []
for i in range(0, int((len(I) / mod_frequency) * sampling_frequency)):
    signal.append(modulation(i / sampling_frequency))

def signal_fun(t):
    try:
        return signal[math.floor(t * sampling_frequency)]
    except:
        return 0

extracted_I = [dot_product(signal_fun, sin_carrier, i / mod_frequency, (i + mod_frequency / mod_frequency) / mod_frequency)/(dot_product(sin_carrier, sin_carrier, i / mod_frequency, (i + mod_frequency / mod_frequency) / mod_frequency)) for i in range(len(I))]
extracted_Q = [dot_product(signal_fun, cos_carrier, i / mod_frequency, (i + mod_frequency / mod_frequency) / mod_frequency)/(dot_product(cos_carrier, cos_carrier, i / mod_frequency, (i + mod_frequency / mod_frequency) / mod_frequency)) for i in range(len(I))]

print(I, list(map(lambda x:x>=0.5,extracted_I)))
print(Q, list(map(lambda x:x>=0.5,extracted_Q)))

plt.plot([i / sampling_frequency for i in range(len(signal))], signal)
plt.plot([i / mod_frequency for i in range(len(I))], list(map(lambda x: x > sum(extracted_I)/len(extracted_I), extracted_I)))
plt.plot([i / mod_frequency for i in range(len(I))], list(map(lambda x: x > sum(extracted_Q)/len(extracted_Q), extracted_Q)))
plt.show()
