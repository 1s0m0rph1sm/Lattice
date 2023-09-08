# sagemath 9.5

from tqdm import tqdm

def make_lattice(n, r, s, h, B, N):
    M = matrix(QQ, N+2, N+2)
    M.set_block(0, 0, matrix.identity(N) * n)
    
    for i, X in tqdm(enumerate(zip(r,s))):
        M[N, i] = int(X[0] * pow(X[1], -1, n)) % n
        
    for i, X in tqdm(enumerate(zip(h, s))):
        M[N+1, i] = int(-X[0] * pow(X[1], -1, n)) % n

    M[N, N] = B / n
    M[N+1, N+1] = B
    return M


def solve(n, r, s, h, B, N):
    M = make_lattice(n, r, s, h, B, N)
    ML = M.LLL()

    candidates = []
    for rows in tqdm(ML):
        k1 = int(abs(rows[0]))
        if 0 < k1 < B:
            candidates.append(k1)
            
    return candidates


if __name__ == "__main__":
    # parameters
    n = 0 # order
    N = 0 # size
    r = [] # signatures
    s = [] # 
    h = [] # msg digest
    B = 0 # max of the nonce

    candidates = solve(n, r, s, h, B, N)
