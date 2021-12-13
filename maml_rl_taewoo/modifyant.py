import xml.etree.ElementTree as elemTree

def modifystr(s, length):
    strs = s.split(" ")
    if len(strs) == 3:
        return str(float(strs[0]) * length) + " " + str(float(strs[1]) * length) + " " + str(float(strs[2]) * length)
    elif len(strs) == 6:
        return str(float(strs[0]) * length) + " " + str(float(strs[1]) * length) + " " + str(float(strs[2]) * length) + " " + str(float(strs[3]) * length) + " " + str(float(strs[4]) * length) + " " + str(float(strs[5]) * length)


def modify(reset_args):
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

    tree.write("vendor/mujoco_models/modified.xml")

modify([1.0, 1.0, 1.0, 1.0])
