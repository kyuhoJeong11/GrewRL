
import xml.etree.ElementTree as elemTree

def modifystr(s, length):
    strs = s.split(" ")
    if len(strs) == 3:
        return str(float(strs[0]) * length) + " " + str(float(strs[1]) * length) + " " + str(float(strs[2]) * length)
    elif len(strs) == 6:
        return str(float(strs[0]) * length) + " " + str(float(strs[1]) * length) + " " + str(float(strs[2]) * length) + " " + str(float(strs[3]) * length) + " " + str(float(strs[4]) * length) + " " + str(float(strs[5]) * length)


tree = elemTree.parse("vendor/mujoco_models/ant.xml")
for body in tree.iter("body"):
    if "name" in body.attrib:
        if(body.attrib["name"] == "aux_1"):
            geom = body.find("geom")
            geom.attrib["fromto"] = modifystr(geom.attrib["fromto"], 2.0)
            body2 = body.find("body")
            body2.attrib["pos"] = modifystr(body2.attrib["pos"], 2.0)
            geom = body2.find("geom")
            geom.attrib["fromto"] = modifystr(geom.attrib["fromto"], 2.0)

tree.write("vendor/mujoco_models/modified.xml")