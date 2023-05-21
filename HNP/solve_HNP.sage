def make_lattice(n, p, T, A, B):
    m = [[0 for i in range(n+2)] for j in range(n+2)]
    for i in range(n):
        m[i][i] = p
        m[n][i] = T[i]
        m[n+1][i] = A[i]
    
    m[n][n] = B/p
    m[n+1][n+1] = B

    M = Matrix(ZZ, m)
    return M


def solve(n, p, T, A, B):
    M = make_lattice(n, p, T, A, B)
    ML = M.LLL()

    # TODO


if __name__ == "__main__":
    # parameters
    n = 0
    p = 0
    T = []
    A = []
    B = []
    solve(n, p, T, A, B)
