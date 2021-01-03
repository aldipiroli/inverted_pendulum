import gym
import PIDController
# from cartpole import CartPoleEnv


if __name__ == "__main__":
    var = PIDController.Variables
    pid = PIDController.PID(10, 1, 1, -30)
    pid.Reset()
    pid.PrintValues()

    env = gym.make('CartPole-v0')

    observation = env.reset()

    for i in range(100):
        env.render()
        var.x = observation[0]
        var.x_dot = observation[1]
        var.th = observation[2]
        var.th_dot = observation[3]

        u = pid.ComputeOutput(var.th)
        action = -1
        if u > 1:
            action = 1
        if u <= -1 :
            action = 0

        if action != -1:
            observation_, reward, done, info = env.step(action)
            observation = observation_
        else:
            observation_, reward, done, info = env.step(0)
            observation_, reward, done, info = env.step(1)
            observation = observation_  
        # print(u.shape)
        # print(done)
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
