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

 
def find_weather_presets():
    rgx = re.compile('.+?(?:(?<=[a-z])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])|$)')
    name = lambda x: ' '.join(m.group(0) for m in rgx.finditer(x))
    presets = [x for x in dir(carla.WeatherParameters) if re.match('[A-Z].+', x)]
    return [(getattr(carla.WeatherParameters, x), name(x)) for x in presets]

log_file = open("log_left.txt", "wt")

try:
    client = carla.Client("localhost", 2000) 
    client.set_timeout(20.0)
    world = client.get_world()
    settings = world.get_settings()
    settings.fixed_delta_seconds = 0.1
    settings.synchronous_mode = True
    world.apply_settings(settings)
    weather_presets = find_weather_presets()
    world.set_weather(weather_presets[0][0])

    blueprint_library = world.get_blueprint_library() 
    bp = blueprint_library.filter("neubility")[0]
    spawn_point = world.get_map().get_spawn_points()[0]
    player = world.spawn_actor(bp, spawn_point)

    value1, value2 = 20.0, 20.0
    for i in range(1000):
        if i > 200:
            value1 = 0.00001
            value2 = 0.00001
        control = carla.VehicleControl(fl=float(value1), fr=float(value2), bl=float(value1), br=float(value2))
        player.apply_control(control)

        v = player.get_velocity()
        velocity = np.sqrt(v.x * v.x + v.y * v.y)
        if v.y > 0:
            velocity = -velocity
        print(velocity)
        log_file.write(str(value1) + "\t" + str(value2) + "\t" + str(velocity) + "\n")
        world.tick()

finally:
    player.destroy()
    settings = world.get_settings()
    settings.synchronous_mode = False
    world.apply_settings(settings)
    print("All cleaned up!")
