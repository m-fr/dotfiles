import subprocess
import json

labels = {
    "0":"󰣚",
    "1":"󱑋",
    "2":"󱑌",
    "3":"󱑍",
    "4":"󱑎",
    "5":"󱑏",
    "6":"󱑐",
    "7":"󱑑",
    "8":"󱑒",
    "9":"󱑓",
    "a":"󱑔",
    "b":"󱑕",
    "c":"󱑖",
    "d":"󱐿",
    "e":"󱑀",
    "f":"󱑁"
}

def getFlags(node):
    if node:
        if node['client']:
            return [node['client']['urgent'], node['client']['shown']]
    
        l = getFlags(node['firstChild'])
        r = getFlags(node['secondChild'])

        return [l[0] or r[0], l[1] or r[1]]
    
    return [False, False]

class desktop:
    def __init__(self, name, empty=False, visible=False, urgent=False):
        self.name = name
        self.short = labels[name] if name in labels else labels['0']
        self.empty = empty
        self.visible = visible
        self.urgent = urgent

class DesktopEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, desktop):
            return {"name":obj.name,
                "short":obj.short,
                "empty":obj.empty,
                "visible":obj.visible,
                "urgent":obj.urgent}
        return json.JSONEncoder.default(self, obj)

monitors = int(subprocess.check_output("mons | grep enabled | wc -l", shell=True).decode("utf-8"))

desktops = []

for i in range(monitors):
    desktops.append([])
    state = json.loads(subprocess.check_output("bspc query -T -m ^"+str(i+1), shell=True).decode("utf-8"))
    for d in state['desktops']:
        if d['root']:
            flags = getFlags(d['root'])
            desktops[i].append(desktop(name=d['name'], visible=flags[1], urgent=flags[0]))
        else:
            desktops[i].append(desktop(name=d['name'], empty=True))

print (json.dumps(desktops, cls=DesktopEncoder))
