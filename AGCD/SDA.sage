with open('public_key.txt', 'r') as f:
    x = list(map(Integer, f.read().replace("[","").replace("]","").split(",")))
with open('output.txt', 'r') as f:
    ct = list(map(Integer, f.read().replace("[","").replace("]","").split(",")))

t = 50
gamma = 2048
eta = 1024
rho = 768

M = Matrix(ZZ, t, t)
M[0, 0] = 2^769
for i in range(1, t):
    M[0, i] = x[i]
    M[i, i] = -x[0]

ML = M.LLL()

v = ML[0]
min = abs(norm(ML[0]) - sqrt(t)*2^(gamma - eta + rho + 1))
for i in ML:
    if min > abs(norm(i) - sqrt(t)*2^(gamma - eta + rho + 1)):
        min = abs(norm(i) - sqrt(t)*2^(gamma - eta + rho + 1))
        v = i

# print(v)

q = v[0] // 2^769
print("q:{}".format(q))
r = x[0] % q
print("r:{}".format(r))
p = (x[0] - r) // q
print("p:{}".format(p))

from Crypto.Util.number import isPrime, long_to_bytes
print(isPrime(p))

m = long_to_bytes(int('0b' + ''.join(str(i%p%2) for i in ct), 2)).decode()
print(m)
