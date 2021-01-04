import gym
import PIDController
from cartpole import CartPoleEnv


if __name__ == "__main__":
    var = PIDController.Variables
    pid_inner = PIDController.PID(50, 0, 1, -139.2996)
    pid_inner.Reset()
    pid_inner.PrintValues()

    pid_outer = PIDController.PID(1, 1, 1, 1)
    pid_outer.Reset()
    pid_outer.PrintValues()

    env = CartPoleEnv()

    observation = env.reset()

    # Block Signals:
    F = 1
    u = 0
    v = 0
    m = 0
    n = 0

    # Simulation Loop:
    for i in range(500):
        env.render()
        var.x = observation[0]
        var.x_dot = observation[1]
        var.th = observation[2]
        var.th_dot = observation[3]

        n = pid_outer.ComputeOutput(var.x)
        v = F - n

        m = pid_inner.ComputeOutput(var.th)
        u = v - m


        action = -1
        if u > 1:
            action = 1
        if u <= -1 :
            action = 0

        observation, reward, done, info = env.step(action)



        # u = pid_inner.ComputeOutput(var.th)
        # observation, reward, done, info = env.step(1, u)

        # action = -1
        # if u > 1:
        #     action = 1
        # if u <= -1 :
        #     action = 0

        # if action != -1:
        #     observation_, reward, done, info = env.step(action, u)
        #     observation = observation_
        # else:
        #     observation_, reward, done, info = env.step(0)
        #     observation_, reward, done, info = env.step(1)
        #     observation = observation_  
        # # print(u.shape)
        # # print(done)
        input()
    env.close()

    # for i_episode in range(20):
    #     observation = env.reset()
    #     for t in range(100):
    #         env.render()
    #         print(observation)
    #         action = env.action_space.sample()
    #         observation, reward, done, info = env.step(action)
    #         if done:
    #             print("Episode finished after {} timesteps".format(t+1))
    #             break
    # env.close()
