class PID:
    def __init__(self, Kp, Ki, Kd):
        self.Kp = Kp
        self.Ki = Ki
        self.Kd = Kd
    def PrintValues(self):
        print("Kp: ", self.Kp, ", Ki", self.Ki, ", Kd: ",self.Kp) 

class Variables:
    def __init__(self):
        self.x = 0
        self.x_dot = 0        
        self.th = 0
        self.th_dot = 0