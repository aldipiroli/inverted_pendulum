import numpy as np

class PID:
    def __init__(self, Kp, Ki, Kd, k):
        self.p = Kp
        self.i = Ki
        self.d = Kd
        self.k = k

        self.Kp = []
        self.Ki = []
        self.Kd = []

        self.e = []

    def Reset(self):
        self.Kp.append(0)
        self.Ki.append(0)
        self.Kd.append(0)

        self.e.append(0)
        
    def PrintValues(self):
        print("p: ", self.p, ", i", self.i, ", d: ",self.p)
        print("Kp: ", self.Kp, ", Ki", self.Ki, ", Kd: ",self.Kp)

    def ComputeOutput(self, th):
        e_ = 0 - th
        self.e.append(e_)

        e_sum =np.sum(self.e)
        e_n = self.e[-1] # en
        e_n_1 = self.e[-2] #e_n-1


        r = self.p * e_n + self.i*e_sum + self.d * (e_n - e_n_1)
        r = self.k * r
        u = 1 - r

        print(u, th)
        return u

class Variables:
    def __init__(self):
        self.x = 0
        self.x_dot = 0        
        self.th = 0
        self.th_dot = 0