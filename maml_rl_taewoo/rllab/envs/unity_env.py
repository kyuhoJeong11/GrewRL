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

import numpy as np

#import traceback
import xml.etree.ElementTree as elemTree

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


def modifystr(s, length, roundDigit = 2):
    strs = s.split(" ")
    #if len(strs) == 3: #body pos
    #    return str(float(strs[0]) * length) + " " + str(float(strs[1]) * length) + " " + str(float(strs[2]) * length)
    #elif len(strs) == 6: #geom fromto
    #    return str(float(strs[0]) * length) + " " + str(float(strs[1]) * length) + " " + str(float(strs[2]) * length) + " " + str(float(strs[3]) * length) + " " + str(float(strs[4]) * length) + " " + str(float(strs[5]) * length)
    
    #myadd
    newStr = str("")
    index = 0
    for x in strs:
        newLength = round(float(strs[index]) * length, roundDigit)
        newStr += str(newLength) + " "
        index += 1

    #print("newStr : {0}, length : {1:0.2}".format(newStr, length))
    return newStr

class UnityGymEnv(Env, Serializable):
    index = 0

    def __init__(self, env_name, record_video=True, video_schedule=None, log_dir=None, record_log=True):
        if log_dir is None:
            if logger.get_snapshot_dir() is None:
                logger.log("Warning: skipping Gym environment monitoring since snapshot_dir not configured.")
            else:
                log_dir = os.path.join(logger.get_snapshot_dir(), "gym_log")
                log_dir = log_dir.replace('\'', '')
        Serializable.quick_init(self, locals())

        #추가함. 
        #env_name = "D:\\grew_svn\\2020\\GitHub\\grewRL\\marathon-envs-0.5.0a + ml-agents-0.5-3.0a + TensorFlowSharp\\UnitySDK\\Build\\test_0914\\Unity Environment.exe"

        #print("env_name : ", env_name)
        #env = gym.envs.make(env_name)

        UnityGymEnv.index += 1 #myadd
        self.index = UnityGymEnv.index #myadd

        if(self.index < 2):
            print("Input Worker ID : ")
            worker_id = int(input()) #myadd
        else:
            worker_id  = self.index

        env = UnityEnv(env_name, worker_id, use_visual=False, multiagent=False) #수정함

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

        self.reinit()

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

    #myadd
    def sample_goals(self, num_goals):
        #r = np.random.uniform(0.5, 1.5, num_goals)
        #return np.array([ [0.01, r[i], 1.0, r[i]] for i in range(num_goals)])
        return np.array([ [np.random.uniform(0.5, 1.5), np.random.uniform(0.5, 1.5), np.random.uniform(0.5, 1.5), np.random.uniform(0.5, 1.5)] for i in range(num_goals)])
        #return np.random.uniform(0.5, 1.5, (num_goals, 4))

    def SetIndex(self, i):
        print("==========================SetIndex ", i)
        #self.index = str(i)

    def reinit(self):
        #다리 수에 따른 변경
        max_leg_count = 6
        reset_args = np.empty(max_leg_count)

        index = 0
        for x in reset_args:
            reset_args[index] = np.random.uniform(0.5, 1.5)
            index += 1

        #print("reset_args : ", reset_args)

        self.modifyXML(4, reset_args) #4족 수정
        self.modifyXML(6, reset_args) #6족 수정
        #self.reset_arg = reset_args

    def modifyXML(self, legCount, reset_args):
        tree = elemTree.parse("D:/grew_svn/2020/GitBlit/GrewRL/marathon-envs-0.5.0a + ml-agents-0.5-3.0a + TensorFlowSharp/UnitySDK/Build/test_maml_1130/Unity Environment_Data/StreamingAssets/N/pybullet_ant_{0}.xml".format(legCount))
        aux_index = 1

        for body in tree.iter("body"):
            if "name" in body.attrib:
                #if(body.attrib["name"] == "aux_" + str(aux_index)):
                if("aux" in body.attrib["name"]):
                    geom = body.find("geom")
                    geom.attrib["fromto"] = modifystr(geom.attrib["fromto"], reset_args[aux_index - 1])
                    body2 = body.find("body")
                    body2.attrib["pos"] = modifystr(body2.attrib["pos"], reset_args[aux_index - 1])
                    geom = body2.find("geom")
                    geom.attrib["fromto"] = modifystr(geom.attrib["fromto"], reset_args[aux_index - 1])
                    aux_index += 1

        tree.write("D:/grew_svn/2020/GitBlit/GrewRL/marathon-envs-0.5.0a + ml-agents-0.5-3.0a + TensorFlowSharp/UnitySDK/Build/test_maml_1130/Unity Environment_Data/StreamingAssets/N/pybullet_ant_{0}_modified{1}.xml".format(legCount, self.index))