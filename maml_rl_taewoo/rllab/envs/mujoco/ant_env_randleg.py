from .mujoco_env import MujocoEnv
from rllab.core.serializable import Serializable
import numpy as np

from rllab.envs.base import Step
from rllab.misc.overrides import overrides
from rllab.misc import logger

import xml.etree.ElementTree as elemTree

def modifystr(s, length):
    strs = s.split(" ")
    if len(strs) == 3:
        return str(float(strs[0]) * length) + " " + str(float(strs[1]) * length) + " " + str(float(strs[2]) * length)
    elif len(strs) == 6:
        return str(float(strs[0]) * length) + " " + str(float(strs[1]) * length) + " " + str(float(strs[2]) * length) + " " + str(float(strs[3]) * length) + " " + str(float(strs[4]) * length) + " " + str(float(strs[5]) * length)


class AntEnvRandLeg(MujocoEnv, Serializable):
    FILE = 'modified.xml'
    def __init__(self, *args, **kwargs):
        self.reset_arg = None
        super(AntEnvRandLeg, self).__init__()
        Serializable.__init__(self, *args, **kwargs)
    
    def SetIndex(self, i):
        self.index = str(i)

    def reinit(self, reset_args):
        print("reset_args : ", reset_args)
        tree = elemTree.parse("vendor/mujoco_models/ant.xml")
        for body in tree.iter("body"):
            if "name" in body.attrib:
                if(body.attrib["name"] == "aux_1"):
                    geom = body.find("geom")
                    geom.attrib["fromto"] = modifystr(geom.attrib["fromto"], reset_args[0])
                    body2 = body.find("body")
                    body2.attrib["pos"] = modifystr(body2.attrib["pos"], reset_args[0])
                    geom = body2.find("geom")
                    geom.attrib["fromto"] = modifystr(geom.attrib["fromto"], reset_args[0])
                if(body.attrib["name"] == "aux_2"):
                    geom = body.find("geom")
                    geom.attrib["fromto"] = modifystr(geom.attrib["fromto"], reset_args[1])
                    body2 = body.find("body")
                    body2.attrib["pos"] = modifystr(body2.attrib["pos"], reset_args[1])
                    geom = body2.find("geom")
                    geom.attrib["fromto"] = modifystr(geom.attrib["fromto"], reset_args[1])
                if(body.attrib["name"] == "aux_3"):
                    geom = body.find("geom")
                    geom.attrib["fromto"] = modifystr(geom.attrib["fromto"], reset_args[2])
                    body2 = body.find("body")
                    body2.attrib["pos"] = modifystr(body2.attrib["pos"], reset_args[2])
                    geom = body2.find("geom")
                    geom.attrib["fromto"] = modifystr(geom.attrib["fromto"], reset_args[2])
                if(body.attrib["name"] == "aux_4"):
                    geom = body.find("geom")
                    geom.attrib["fromto"] = modifystr(geom.attrib["fromto"], reset_args[3])
                    body2 = body.find("body")
                    body2.attrib["pos"] = modifystr(body2.attrib["pos"], reset_args[3])
                    geom = body2.find("geom")
                    geom.attrib["fromto"] = modifystr(geom.attrib["fromto"], reset_args[3])

        self.FILE = "modified" + self.index + ".xml"
        tree.write("vendor/mujoco_models/modified" + self.index + ".xml")
        self.mujoco_model_reset(None)
        self.reset_arg = reset_args

    def get_current_obs(self):
        return np.concatenate([
            self.model.data.qpos.flat,
            self.model.data.qvel.flat,
            np.clip(self.model.data.cfrc_ext, -1, 1).flat,
            self.get_body_xmat("torso").flat,
            self.get_body_com("torso"),
        ]).reshape(-1)

    def sample_goals(self, num_goals):
        #r = np.random.uniform(0.5, 1.5, num_goals)
        #return np.array([ [0.01, r[i], 1.0, r[i]] for i in range(num_goals)])
        return np.array([ [np.random.uniform(0.5, 1.5), np.random.uniform(0.5, 1.5), np.random.uniform(0.5, 1.5), np.random.uniform(0.5, 1.5)] for i in range(num_goals)])
        #return np.random.uniform(0.5, 1.5, (num_goals, 4))

    @overrides
    def reset(self, init_state=None, reset_args=None, **kwargs):
        print("RESET!", reset_args)
        tree = elemTree.parse("vendor/mujoco_models/ant.xml")
        if reset_args is not None:
            for body in tree.iter("body"):
                if "name" in body.attrib:
                    if(body.attrib["name"] == "aux_1"):
                        geom = body.find("geom")
                        geom.attrib["fromto"] = modifystr(geom.attrib["fromto"], reset_args[0])
                        body2 = body.find("body")
                        body2.attrib["pos"] = modifystr(body2.attrib["pos"], reset_args[0])
                        geom = body2.find("geom")
                        geom.attrib["fromto"] = modifystr(geom.attrib["fromto"], reset_args[0])
                    if(body.attrib["name"] == "aux_2"):
                        geom = body.find("geom")
                        geom.attrib["fromto"] = modifystr(geom.attrib["fromto"], reset_args[1])
                        body2 = body.find("body")
                        body2.attrib["pos"] = modifystr(body2.attrib["pos"], reset_args[1])
                        geom = body2.find("geom")
                        geom.attrib["fromto"] = modifystr(geom.attrib["fromto"], reset_args[1])
                    if(body.attrib["name"] == "aux_3"):
                        geom = body.find("geom")
                        geom.attrib["fromto"] = modifystr(geom.attrib["fromto"], reset_args[2])
                        body2 = body.find("body")
                        body2.attrib["pos"] = modifystr(body2.attrib["pos"], reset_args[2])
                        geom = body2.find("geom")
                        geom.attrib["fromto"] = modifystr(geom.attrib["fromto"], reset_args[2])
                    if(body.attrib["name"] == "aux_4"):
                        geom = body.find("geom")
                        geom.attrib["fromto"] = modifystr(geom.attrib["fromto"], reset_args[3])
                        body2 = body.find("body")
                        body2.attrib["pos"] = modifystr(body2.attrib["pos"], reset_args[3])
                        geom = body2.find("geom")
                        geom.attrib["fromto"] = modifystr(geom.attrib["fromto"], reset_args[3])

            self.FILE = "modified" + self.index + ".xml"
            tree.write("vendor/mujoco_models/modified" + self.index + ".xml")
            self.mujoco_model_reset(init_state)
            self.reset_arg = reset_args
        else:
            self.reset_mujoco(init_state)
            


        #self._goal_vel = np.random.uniform(0.0, 3.0)
        self.model.forward()
        self.current_com = self.model.data.com_subtree[0]
        self.dcom = np.zeros_like(self.current_com)
        obs = self.get_current_obs()
        return obs


    def step(self, action):
        #import traceback
        #for line in traceback.format_stack():
        #    print(line.strip())

        self.forward_dynamics(action)
        comvel = self.get_body_comvel("torso")
        #forward_reward = -np.abs(comvel[0] - self._goal_vel) + 1.0 # make it happy, not suicidal
        forward_reward = comvel[0]
        lb, ub = self.action_bounds
        scaling = (ub - lb) * 0.5
        ctrl_cost = 0.5 * 1e-2 * np.sum(np.square(action / scaling))
        contact_cost = 0.5 * 1e-3 * np.sum(
            np.square(np.clip(self.model.data.cfrc_ext, -1, 1))),
        survive_reward = 0.05
        reward = forward_reward - ctrl_cost - contact_cost + survive_reward
        state = self._state
        notdone = np.isfinite(state).all() \
            and state[2] >= 0.2 and state[2] <= 1.0
        done = not notdone
        ob = self.get_current_obs()
        return Step(ob, float(reward), done)

    @overrides
    def log_diagnostics(self, paths, prefix=''):
        progs = [
            path["observations"][-1][-3] - path["observations"][0][-3]
            for path in paths
        ]
        logger.record_tabular(prefix+'AverageForwardProgress', np.mean(progs))
        logger.record_tabular(prefix+'MaxForwardProgress', np.max(progs))
        logger.record_tabular(prefix+'MinForwardProgress', np.min(progs))
        logger.record_tabular(prefix+'StdForwardProgress', np.std(progs))

    def __getstate__(self):
        state = super().__getstate__()
        state["reset_arg"] = self.reset_arg

        return state
    
    def __setstate__(self, state):
        super().__setstate__(state)
        if state["reset_arg"] != None:
            self.reinit(state["reset_arg"])
