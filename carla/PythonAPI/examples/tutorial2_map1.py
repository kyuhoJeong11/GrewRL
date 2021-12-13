import glob
import os
import sys
import random
import time
import numpy as np
import cv2
import math
import threading
import re
from datetime import datetime

'''
Carla 패키지가 사용하는 egg파일 탐색
'''
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

class Worker(threading.Thread) :
    def __init__(self, world, vehicle):
        super().__init__()
        self.world = world
        self.vehicle = vehicle

    def run(self):
        i = 0
        while True:
            a = input()

            if a == "":
                transform = world.get_map().get_spawn_points()[i]
                i += 1

                vehicle.set_transform(transform)

actor_list = []

# 서버 접속 및 차량
try:
    client = carla.Client("localhost", 2000)  # 서버 접속
    client.set_timeout(20.0)
    world = client.get_world()
    weather_presets = find_weather_presets()
    world.set_weather(weather_presets[0][0])
    blueprint_library = world.get_blueprint_library()  # blueprint access

    bp = blueprint_library.filter("dummy")[0]  # spawn할 vehicle의 bp 가져오기
    spawn_point = world.get_map().get_spawn_points()[6]
    #spawn_point = world.get_map().get_spawn_points()[1]

    vehicle = world.spawn_actor(bp, spawn_point)  # 차 spawn

    #vehicle.set_autopilot(True)
    actor_list.append(vehicle)  # actor list에 차량 추가.

    control = carla.VehicleControl()

    control.throttle_fl = 10.0
    control.throttle_fr = 10.0
    control.throttle_bl = 10.0
    control.throttle_br = 10.0
    control.brake_fl = 0.0
    control.brake_fr = 0.0
    control.brake_bl = 0.0
    control.brake_br = 0.0

    vehicle.apply_control(control)

    bp = blueprint_library.filter("model3")[0]  # spawn할 vehicle의 bp 가져오기
    spawn_point = world.get_map().get_spawn_points()[0]

    vehicle2 = world.spawn_actor(bp, spawn_point)  # 차 spawn

    actor_list.append(vehicle2)  # actor list에 차량 추가.
    '''
    for i in range(600):
        time.sleep(0.05)
        if i == 200:
            control.throttle_fl = 20.0
            control.throttle_fr = 20.0
            control.throttle_bl = 20.0
            control.throttle_br = 20.0
            control.brake_fl = 0.0
            control.brake_fr = 0.0
            control.brake_bl = 0.0
            control.brake_br = 0.0

            vehicle.apply_control(control)

        elif i == 390 :
            control.throttle_fl = 50.0
            control.throttle_fr = 10.0
            control.throttle_bl = 50.0
            control.throttle_br = 10.0
            control.brake_fl = 0.0
            control.brake_fr = 0.0
            control.brake_bl = 0.0
            control.brake_br = 0.0

            vehicle.apply_control(control)

        elif i == 500 :
            control.throttle_fl = 0.0
            control.throttle_fr = 0.0
            control.throttle_bl = 0.0
            control.throttle_br = 0.0
            control.brake_fl = 5.0
            control.brake_fr = 5.0
            control.brake_bl = 5.0
            control.brake_br = 5.0

            vehicle.apply_control(control)
    '''

    while True:
        time.sleep(0.005)
        '''
        rotation = vehicle.get_transform().rotation
        location = vehicle.get_transform().location
        print("rotation : " + str(rotation) + "locataion : " + str(location))
        '''
        world.tick()

# 서버 종료 시 액터 파괴. 파괴하지 않는다면 서버에 액터가 계속 존재함.
finally:
    for actor in actor_list:
        actor.destroy()
    print("All cleaned up!")