import gym

env = gym.make('BipedalWalker-v3')



for eps in range(20):
	obsv = env.reset()
	for t in range(10000):
		env.render()
		print(obsv)
		action = env.action_space.sample()
		obsv, reward, done, info = env.step(action)
		if done:
			print("{} timesteps taken for the episode".format(t+1))
			break


