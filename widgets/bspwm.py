import subprocess
import json

def getFlags(node):
    if node:
        if node['client']:
            return [node['client']['urgent'], node['client']['shown']]
    
        l = getFlags(node['firstChild'])
        r = getFlags(node['secondChild'])

        return [l[0] or r[0], l[1] or r[1]]
    
    return [False, False]

monitors = int(subprocess.check_output("mons | grep enabled | wc -l", shell=True).decode("utf-8"))

labels = {"I":"","II":"","III":"","IV":"","V":"","VI":"","VII":"","VIII":"","IX":"","X":""}
defaultlabel = ""

width = 5

print('(box :orientation "v" :space-evenly false :class "bspwm"')
print('(box :orientation "h" :space-evenly false')
ctr = 1
for i in range(monitors):
    state = json.loads(subprocess.check_output("bspc query -T -m ^"+str(i+1), shell=True).decode("utf-8"))
    for d in state['desktops']:
        if d['root']:
            flags = getFlags(d['root'])
            f = "" + " urgent" if flags[0] else "" + " shown" if flags[1] else ""
            print("(desktop :name '", d['name'],
                "' :label '", labels[d['name']] if d['name'] in labels else defaultlabel,
                "' :class '", f, "')", sep='')
        else:
            print("(desktop :name '", d['name'],
                "' :label '", labels[d['name']] if d['name'] in labels else defaultlabel,
                "' :class 'empty')", sep='')
        if ctr%width == 0:
            print(')(box :orientation "h" :space-evenly false')
        ctr+=1
print('))')
