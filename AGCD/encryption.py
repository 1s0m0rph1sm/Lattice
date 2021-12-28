from random import SystemRandom
from Crypto.Util.number import getPrime, bytes_to_long, long_to_bytes

class AGCD:
    def __init__(self):
        self.x = []
        self.rand = SystemRandom()
        self.t = 50
        self.BITS = 1024
        self._p  = getPrime(self.BITS)
    
    def key_generation(self):
        for i in range(self.t):
            q = self.rand.randint(1, 1<<self.BITS)
            r = self.rand.randint(1, 1<<(3*self.BITS//4))
            self.x.append(self._p*q + 2*r)

    def sum(self):
        S = 0
        for i in range(self.t):
            S += (self.x[i] * self.rand.randint(0, 1))
        return S


    def encryption(self, m):
        self.key_generation()
        mbits = bin(bytes_to_long(m.encode()))[2:]

        ct = []
        for i in mbits:
            ct.append(int(i) + self.sum())

        return ct

    def decryption(self, ct):
        m = long_to_bytes(int('0b' + ''.join(str(i % self._p % 2) for i in ct), 2))
        return m.decode()



if __name__ == "__main__":
    e = AGCD()
    m = "Hello World"
    ct = e.encryption(m)
    assert m == e.decryption(ct)

    with open("public_key.txt", "w") as f:
        f.write(str(e.x))
    with open("output.txt", "w") as f:
        f.write(str(ct))
    
