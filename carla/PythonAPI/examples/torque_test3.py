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


actor_list = []
log_file = open("log_left.txt", "wt")

# 서버 접속 및 차량
try:
    client = carla.Client("localhost", 2000)  # 서버 접속
    client.set_timeout(20.0)
    world = client.get_world()
    '''
    settings = world.get_settings()
    settings.fixed_delta_seconds = 0.1
    settings.synchronous_mode = True
    world.apply_settings(settings)
    '''
    blueprint_library = world.get_blueprint_library()  # blueprint access

    bp = blueprint_library.filter("neubility")[0]  # spawn할 vehicle의 bp 가져오기
    spawn_point = world.get_map().get_spawn_points()[0]

    vehicle = world.spawn_actor(bp, spawn_point)  # 차 spawn
    actor_list.append(vehicle)  # actor list에 차량 추가.

    bp = blueprint_library.filter("neubility")[0]  # spawn할 vehicle의 bp 가져오기

    spawn_point = world.get_map().get_spawn_points()[1]

    vehicle2 = world.spawn_actor(bp, spawn_point)  # 차 spawn
    actor_list.append(vehicle2)  # actor list에 차량 추가.
    '''
    fl = carla.WheelPhysicsControl(tire_friction=5.0)
    fr = carla.WheelPhysicsControl(tire_friction=5.0)
    rl = carla.WheelPhysicsControl(tire_friction=5.0)
    rr = carla.WheelPhysicsControl(tire_friction=5.0)

    wheels = [fl, fr, rl, rr]
    '''
    physics_control = vehicle.get_physics_control()

    #physics_control.wheels = wheels
    physics_control.torque_curve = [[0.0, 74.0], [1.0, 158.0]]

    vehicle.apply_physics_control(physics_control)

    control = vehicle.get_control()

    control.throttle = 1.0
    control.brake = 0.0

    vehicle.apply_control(control)
    vehicle2.apply_control(control)


    for i in range(2000):
        time.sleep(0.05)
        if i == 1000:
            control.throttle = 0.0
            control.brake = 1.0

            vehicle.apply_control(control)
            vehicle2.apply_control(control)

        v = vehicle.get_velocity()
        velocity = np.sqrt(v.x * v.x + v.y * v.y)
        #if v.y > 0:
        #    velocity = -velocity
        print(velocity)
        log_file.write(str(velocity) + "\n")
        world.tick()

    # vehicle의 control 정보를 가져와서 필요할 때 마다 수정하여 적용 가능.
    '''
    control = vehicle.get_control()

    control.fl = 10.0
    control.fr = 200.0
    control.bl = 10.0
    control.br = 200.0

    vehicle.apply_control(control)
    

    while True:
        time.sleep(0.005)
        world.tick()
    '''

# 서버 종료 시 액터 파괴. 파괴하지 않는다면 서버에 액터가 계속 존재함.
finally:
    for actor in actor_list:
        actor.destroy()
    print("All cleaned up!")