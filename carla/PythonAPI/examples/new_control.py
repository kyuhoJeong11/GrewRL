import glob
import os
import sys
import random
import time
import numpy as np
import cv2
import math
import threading
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
    blueprint_library = world.get_blueprint_library()  # blueprint access

    bp = blueprint_library.filter("neubility")[0]  # spawn할 vehicle의 bp 가져오기
    spawn_point = world.get_map().get_spawn_points()[0]

    vehicle = world.spawn_actor(bp, spawn_point)  # 차 spawn
    actor_list.append(vehicle)

    control = carla.VehicleControl()

    control.throttle_fl = 100.0
    control.throttle_fr = 100.0
    control.throttle_bl = 100.0
    control.throttle_br = 100.0
    control.brake_fl = 0.0
    control.brake_fr = 0.0
    control.brake_bl = 0.0
    control.brake_br = 0.0

    vehicle.apply_control(control)

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