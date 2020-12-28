import gym
import PIDController


if __name__ == "__main__":
    var = PIDController.Variables
    pid = PIDController.PID(1, 2, 3)
    pid.PrintValues()

    env = gym.make('CartPole-v0')
    env.reset()
    for _ in range(1000):
        env.render()
        observation, reward, done, info  = env.step(1)  
        var.x = observation[0]
        var.x_dot = observation[1]
        var.th = observation[2]
        var.th_dot = observation[3]
        print(done)
    env.close()
