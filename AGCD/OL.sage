def load_parameters():
    with open('public_key.txt', 'r') as f:
        x = list(map(Integer, f.read().replace("[","").replace("]","").split(",")))
    with open('output.txt', 'r') as f:
        ct = list(map(Integer, f.read().replace("[","").replace("]","").split(",")))

    return x, ct

def OL(x, t, gamma, rho, eta):
    R = 2^rho

    B = Matrix(ZZ, t - 1, t)
    for i in range(t - 1):
        B[i, 0] = x[i + 1]
        B[i, i + 1] = R
    M = B.LLL()
    BB = B*B.T
    d = BB.determinant()
    

if __name__ == "__main__":
    t = 50
    gamma = 2048
    eta = 1024
    rho = 768
    x, ct = load_parameters()
    p = OL(x, t, gamma, rho, eta)
    
