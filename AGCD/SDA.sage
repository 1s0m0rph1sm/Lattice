def load_parameters():
    with open('public_key.txt', 'r') as f:
        x = list(map(Integer, f.read().replace("[","").replace("]","").split(",")))
    with open('output.txt', 'r') as f:
        ct = list(map(Integer, f.read().replace("[","").replace("]","").split(",")))

    return x, ct

def SDA(x, t, gamma, rho, eta):
    M = Matrix(ZZ, t, t)
    M[0, 0] = 2^769
    for i in range(1, t):
        M[0, i] = x[i]
        M[i, i] = -x[0]

    ML = M.LLL()

    d = ML.determinant()
    assert d == 2^(rho + 1) * x[0]^(t - 1)
    assert sqrt(t)*2^(gamma - eta + rho + 1) < sqrt(t/(2*pi*e))*d^(1/t)

    v = ML[0]
    min = abs(norm(ML[0]) - sqrt(t)*2^(gamma - eta + rho + 1))
    for i in ML:
        if min > abs(norm(i) - sqrt(t)*2^(gamma - eta + rho + 1)):
            min = abs(norm(i) - sqrt(t)*2^(gamma - eta + rho + 1))
            v = i

    # v[0] = 2^(rho + 1) * q_0
    q0 = v[0] // 2^(rho + 1)
    r0 = x[0] % q0
    p = (x[0] - r0) // q0
    print("p:{}".format(p))

    assert is_prime(p)

    return p


def decryption(ct, p):
    ct = '0b' + ''.join(str(i%p%2) for i in ct)
    m = int(ct, 2).to_bytes((len(ct) - 1) // 8, byteorder='big').decode()
    return m

if __name__ == "__main__":
    t = 50
    gamma = 2048
    eta = 1024
    rho = 768
    x, ct = load_parameters()
    p = SDA(x, t, gamma, rho, eta)
    print(decryption(ct, p))
