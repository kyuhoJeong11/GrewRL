import glob
import os
import sys
import random
import time
import numpy as np
#import cv2
import math
import re
from datetime import datetime

try:
    sys.path.append(glob.glob('../carla/dist/carla-*%d.%d-%s.egg' % (
        sys.version_info.major,
        sys.version_info.minor,
        'win-amd64' if os.name == 'nt' else 'linux-x86_64'))[0])
except IndexError:
    pass

import carla

try:
    client = carla.Client("localhost", 2000)
    client.set_timeout(20.0)
    world = client.get_world()
    settings = world.get_settings()
    settings.fixed_delta_seconds = 0.1
    settings.synchronous_mode = True
    world.apply_settings(settings)

    blueprint_library = world.get_blueprint_library() 
    bp = blueprint_library.filter("model3")[0]
    spawn_point = world.get_map().get_spawn_points()[0]
    player = world.spawn_actor(bp, spawn_point)

    player.set_autopilot(True)

    for i in range(1000):
        time.sleep(0.05)
        if i == 300:
            settings.fixed_delta_seconds = 0.1
            world.apply_settings(settings)

        elif i == 600:
            settings.fixed_delta_seconds = 0.01
            world.apply_settings(settings)

        elif i == 900:
            settings.fixed_delta_seconds = 0.001
            world.apply_settings(settings)

        world.tick()

finally:
    player.destroy()
    settings = world.get_settings()
    settings.synchronous_mode = False
    world.apply_settings(settings)
    print("All cleaned up!")
