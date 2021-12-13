#!/usr/bin/env python

# Copyright (c) 2019 Computer Vision Center (CVC) at the Universitat Autonoma de
# Barcelona (UAB).
#
# This work is licensed under the terms of the MIT license.
# For a copy, see <https://opensource.org/licenses/MIT>.

"""Spawn NPCs into the simulation"""

import glob
import os
import sys
import time
import threading

try:
    sys.path.append(glob.glob('../bridgeTest/RightDrive/PythonAPI/carla/dist/carla-*%d.%d-%s.egg' % (
        sys.version_info.major,
        sys.version_info.minor,
        'win-amd64' if os.name == 'nt' else 'linux-x86_64'))[0])
except IndexError:
    pass

import carla

import argparse
import logging
from numpy import random

actor_list = []
vehicle_list = []
right = True
right_neub = None
left_neub = None
connect1 = False 
connect2 = False

# 소환된 차량의 control을 진행할 python 파일 실행을 위한 thread
class RunPython(threading.Thread) :
    def __init__(self):
        super().__init__()

    def run(self):
        global right

        print("python start")

        if right is True :
            os.system('python3 right_autopilot.py')

        else :   
            os.system('python3 left_autopilot.py') 

        print("python finish")

# 차량의 좌측 / 우측 소환 및 파이썬 파일 실행을 위한 bridge thread
class Bridge(threading.Thread) :
    def __init__(self, client1, port1, client2, port2):
        super().__init__()
        #각각의 Carla Server의 ip, port 정보 초기화
        self.ip1 = client1
        self.port1 = port1
        self.ip2 = client2
        self.port2 = port2

        print("thread started")

    def run(self):
        global right
        global connect1
        global connect2

        while True:
            a = input("press Enter key to change world")

            if a == "":
                # 우측통행 Carla에서.
                if right is True:
                    print("start world 2")

                    # right drive server에 연결
                    if connect1 is False :
                        client = carla.Client(self.ip1, self.port1)
                        client.set_timeout(20.0)
                        connect1 = True
                        connect2 = False

                    #world, traffic manager, blueprint library setting
                    world = client.get_world()
                    tm = client.get_trafficmanager(8500)
                    blueprint_library = world.get_blueprint_library()

                    # actor list 생성 후 actor list를 바탕으로 vehicle list 생성
                    actor_list = world.get_actors()
                    vehicle_list = actor_list.filter('vehicle.*')

                    for vehicle in vehicle_list:
                        # vehicle의 오토 파일럿 중지 이후, 모든 차량의 control 값 초기화 
                        vehicle.set_autopilot(False, tm.get_port())

                        transform = vehicle.get_transform()
                        transform.location.z += 0.2

                        control = vehicle.get_control()

                        control.throttle = 0.0
                        control.steer = 0.0
                        control.brake = 1.0
                        control.hand_brake = True
                        control.reverse = False
                        control.manual_gear_shift = False
                        control.gear = 0
                        control.fl = 0.0
                        control.fr = 0.0
                        control.bl = 0.0
                        control.br = 0.0

                        vehicle.apply_control(control)

                    #actor list를 가져와서 vehicle actor가 존재할 경우 파괴
                    actor_list = world.get_actors()

                    for actor in actor_list:
                        print(actor.type_id)
                        if 'vehicle' in actor.type_id:
                            actor.destroy()

                    # left drive server에 연결 
                    if connect2 is False:
                        client = carla.Client(self.ip2, self.port2)
                        client.set_timeout(20.0)
                        connect1 = False
                        connect2 = True

                    world = client.get_world()
                    blueprint_library = world.get_blueprint_library()

                    # left drive server에 차량 생성
                    for vehicle in vehicle_list:
                        bp = blueprint_library.filter(vehicle.type_id)[0]

                        moved_vehicle = world.try_spawn_actor(bp, transform)

                    right = False           

                    # 차량 control을 위한 python thread 실행 
                    python_thread = RunPython()
                    python_thread.daemon = True
                    python_thread.start()

                    print("stop world 1")

                # 좌측통행 Carla에서.
                elif right is False:
                    print("start world 1")

                    # left drive server에 연결
                    if connect2 is False:
                        client = carla.Client(self.ip2, self.port2)
                        client.set_timeout(20.0)
                        connect1 = False
                        connect2 = True

                    #world, traffic manager, blueprint library setting
                    world = client.get_world()
                    tm = client.get_trafficmanager(9000)
                    blueprint_library = world.get_blueprint_library()

                    # actor list 생성 후 actor list를 바탕으로 vehicle list 생성
                    actor_list = world.get_actors()
                    vehicle_list = actor_list.filter('vehicle.*')

                    for vehicle in vehicle_list:
                        # vehicle의 오토 파일럿 중지 이후, 모든 차량의 control 값 초기화 
                        vehicle.set_autopilot(False, tm.get_port())

                        transform = vehicle.get_transform()
                        transform.location.z += 0.2

                        control = vehicle.get_control()

                        control.throttle = 0.0
                        control.steer = 0.0
                        control.brake = 1.0
                        control.hand_brake = True
                        control.reverse = False
                        control.manual_gear_shift = False
                        control.gear = 0
                        control.fl = 0.0
                        control.fr = 0.0
                        control.bl = 0.0
                        control.br = 0.0

                        vehicle.apply_control(control)

                    #actor list를 가져와서 vehicle actor가 존재할 경우 파괴
                    actor_list = world.get_actors()

                    for actor in actor_list:
                        if 'vehicle' in actor.type_id:
                            actor.destroy()

                    # right drive server에 연결
                    if connect1 is False :
                        client = carla.Client(self.ip1, self.port1)
                        client.set_timeout(20.0)
                        connect1 = True
                        connect2 = False

                    world = client.get_world()
                    blueprint_library = world.get_blueprint_library()

                    # right drive server에 차량 생성
                    for vehicle in vehicle_list:
                        bp = blueprint_library.filter(vehicle.type_id)[0]

                        moved_vehicle = world.try_spawn_actor(bp, transform)

                    right = True

                    # 차량 control을 위한 python thread 실행
                    python_thread = RunPython()
                    python_thread.daemon = True
                    python_thread.start()

                    print("stop world 2")

def main():
    # args를 관리함. client, port의 default값을 변경 가능.
    argparser = argparse.ArgumentParser(
        description=__doc__)
    argparser.add_argument(
        '-c1', '--client1',
        metavar='C',
        default='192.168.80.55',
        help='IP of Client1 (default: 192.168.80.55)')
    argparser.add_argument(
        '-p1', '--port1',
        metavar='P',
        default=2000,
        type=int,
        help='Port of Client1 (default: 2000)')
    argparser.add_argument(
        '-c2', '--client2',
        metavar='C',
        default='192.168.80.55',
        help='IP of Client2 (default: 192.168.80.55)')
    argparser.add_argument(
        '-p2', '--port2',
        metavar='P',
        default=3000,
        type=int,
        help='Port of Client2 (default: 3000)')
    argparser.add_argument(
        '--sync',
        action='store_true',
        help='Synchronous mode execution')
    args = argparser.parse_args()


    print("bridge started")

    # 프로그램 실행 중 키 입력을 위해 thread 사용.
    bridge_thread = Bridge(args.client1, args.port1, args.client2, args.port2)
    bridge_thread.daemon = True
    bridge_thread.start()

    # 첫 실행 시 차량 소환 / 차량 autopilot 적용을 위해 실행 
    python_thread = RunPython()
    python_thread.daemon = True
    python_thread.start()

    while True:
       time.sleep(1)

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        pass
    finally:
        # bridge 종료 시, process 강제 종료
        os.system('pkill -9 right_autopilot')
        os.system('pkill -9 left_autopilot')
        print('\ndone.')
