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

actor_list = None
vehicle = None

try:
    # server 접속 및 sync 설정 
    client = carla.Client("192.168.80.55", 2000)
    client.set_timeout(20.0)

    world = client.get_world()
    tm = client.get_trafficmanager(8500)
    tm.set_synchronous_mode(True)
    settings = world.get_settings()
    settings.synchronous_mode = True
    settings.fixed_delta_seconds = 0.05
    world.apply_settings(settings)

    actor_list = world.get_actors()
    vehicle_list = actor_list.filter('vehicle.*')
    blueprint_library = world.get_blueprint_library()

    # server에 vehicle이 존재하지 않을 시 새로 생성
    if len(vehicle_list) is int(0) :
        bp = blueprint_library.filter("model3")[0]
        spawn_point = world.get_map().get_spawn_points()[0]

        vehicle = world.try_spawn_actor(bp, spawn_point)

    # server에 vehicle이 존재할 경우 해당 vehicle 사용
    else:
        vehicle = vehicle_list[0]       

    vehicle.set_autopilot(True, tm.get_port())

    # vehicle이 존재하는 동안 프로그램이 종료되지 않도록 설정.
    while vehicle.is_alive is True:
        time.sleep(0.005)
        world.tick()

finally:
    # right drive server 사용이 종료되었으므로, sync모드 해제
    vehicle.destroy()
    settings = world.get_settings()
    settings.synchronous_mode = False
    world.apply_settings(settings)
    print("All cleanede up!")
