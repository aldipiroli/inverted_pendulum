import numpy as np

class Controller:
    def __init__(self):
        self.n = 0
        self.e = []

    def Reset(self):
        self.e.append(0)

    def ComputeOutput(self, th):
        e_ = 0 - th
        self.e.append(e_)




class Variables:
    def __init__(self):
        self.x = 0
        self.x_dot = 0        
        self.th = 0
        self.th_dot = 0