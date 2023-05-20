# Low density attack for 0/1 knapsack
# Language: sagemath
# Made by DongHyeon. Kim 

from Crypto.Util.number import long_to_bytes

class LatticeHack:
    def __init__(self, pubKey, encryptedMessage):
        self.pubKey = pubKey
        self.keyLength = len(pubKey)    
        self.encryptedMessage = encryptedMessage

        d = self.keyLength / log(max(pubKey), 2)
        if d < 0.6463:
            self.attackElement = 0
        elif 0.6408 <= d < 0.9408:
            self.attackElement = 1/2
        else:
            print("Can't hack this cryptosystem with 'low density attack' :(")
    
    def makeLattice(self):
        M = [[0 for i in range(self.keyLength + 1)] for j in range(self.keyLength + 1)]
        for i in range(self.keyLength):
            M[i][i] = 1
            M[i][self.keyLength] = self.pubKey[i]
            M[self.keyLength][i] = -self.attackElement
        M[self.keyLength][self.keyLength] = -self.encryptedMessage

        return Matrix(M)

    def checkVector(self, row):
        for i in row:
            if not(-self.attackElement <= i <= self.attackElement):
                return False
        return True

    def encryption(self, row):
        p = 0
        for i in range(self.keyLength):
            p += (row[i] * self.pubKey[i])
        return p

    def hack(self):
        ML = self.makeLattice().LLL()
        for i in range(self.keyLength + 1):
            if self.checkVector(ML[i][:-1]):
                message = [(j + self.attackElement) for j in ML[i][:-1]]
                if self.encryption(message) != self.encryptedMessage: continue
                
                message = '0b' + ''.join([str(j) for j in message])
                try:
                    message = long_to_bytes(int(message, 2)).decode()
                except:
                    message = '0b' + message[2:][::-1]
                    message = long_to_bytes(int(message, 2)).decode()
                print(message)
                return

if __name__ == "__main__":
    # Modify it!
    # pubKey = 
    # encryptedMessage = 

    attack = LatticeHack(pubKey, encryptedMessage)
    attack.hack()
