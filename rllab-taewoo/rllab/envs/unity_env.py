import gym
import gym.wrappers
import gym.envs
import gym.spaces

from gym_unity.envs import UnityEnv

import os
import os.path as osp
from rllab.envs.base import Env, Step
from rllab.core.serializable import Serializable
from rllab.spaces.box import Box
from rllab.spaces.discrete import Discrete
from rllab.spaces.product import Product
from rllab.misc import logger
import logging

#import traceback

def convert_gym_space(space):
    if isinstance(space, gym.spaces.Box):
        return Box(low=space.low, high=space.high)
    elif isinstance(space, gym.spaces.Discrete):
        return Discrete(n=space.n)
    elif isinstance(space, gym.spaces.Tuple):
        return Product([convert_gym_space(x) for x in space.spaces])
    else:
        raise NotImplementedError


class CappedCubicVideoSchedule(object):
    def __call__(self, count):
        return monitor.capped_cubic_video_schedule(count)


class FixedIntervalVideoSchedule(object):
    def __init__(self, interval):
        self.interval = interval

    def __call__(self, count):
        return count % self.interval == 0


class NoVideoSchedule(object):
    def __call__(self, count):
        return False


class UnityGymEnv(Env, Serializable):
    def __init__(self, env_name, record_video=True, video_schedule=None, log_dir=None, record_log=True):
        if log_dir is None:
            if logger.get_snapshot_dir() is None:
                logger.log("Warning: skipping Gym environment monitoring since snapshot_dir not configured.")
            else:
                log_dir = os.path.join(logger.get_snapshot_dir(), "gym_log")
                log_dir = log_dir.replace('\'', '')
        Serializable.quick_init(self, locals())

        #추가함. 빌드 파일로 실행할때. 에디터와 연결할 때는 None으로.
        #env_name = "D:\\grew_svn\\2020\\GitHub\\grewRL\\marathon-envs-0.5.0a + ml-agents-0.5-3.0a + TensorFlowSharp\\UnitySDK\\Build\\test_0914\\Unity Environment.exe"
        
        #print("env_name : ", env_name)
        #env = gym.envs.make(env_name)

        env = UnityEnv(env_name, 0, use_visual=False, multiagent=True) #수정함
        self.env = env
        self.env_id = 1#env.spec.id

        #monitor.logger.setLevel(logging.WARNING)

        assert not (not record_log and record_video)

        if log_dir is None or record_log is False:
            self.monitoring = False
        else:
            if not record_video:
                video_schedule = NoVideoSchedule()
            else:
                if video_schedule is None:
                    video_schedule = CappedCubicVideoSchedule()
            #self.monitor = monitor.Monitor(self.env)
            #self.monitor.start(log_dir, video_schedule, force=True)  # add 'force=True' if want overwrite dirs
            self.monitoring = False

        self._observation_space = convert_gym_space(env.observation_space)
        self._action_space = convert_gym_space(env.action_space)
        self._horizon = 3e5#env.spec.max_episode_steps #env.spec.timestep_limit
        self._log_dir = log_dir

    @property
    def observation_space(self):
        return self._observation_space

    @property
    def action_space(self):
        return self._action_space

    @property
    def horizon(self):
        return self._horizon

    def reset(self, **kwargs):
        if hasattr(self.env, 'monitor'):
            if hasattr(self.env.monitor, 'stats_recorder'):
                recorder = self.env.monitor.stats_recorder
                if recorder is not None:
                    recorder.done = True
        return self.env.reset()

    def step(self, action):
        #print("step ===================================")
        #for line in traceback.format_stack():
        #    print(line)

        next_obs, reward, done, info = self.env.step(action)
        
        return Step(next_obs, reward, done, **info)

    def render(self):
        self.env.render()

    def terminate(self):
        if self.monitoring:
            self.monitor.close()
            if self._log_dir is not None:
                print("""
    ***************************

    Training finished! You can upload results to OpenAI Gym by running the following command:

    python scripts/submit_gym.py %s

    ***************************
                """ % self._log_dir)
