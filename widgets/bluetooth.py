import subprocess
import json

ifaces = subprocess.check_output("bluetoothctl list | grep Controller | cut -d' ' -f2", shell=True).decode("utf-8").strip().split("\n")

labels = {"ethernet":"", "loopback":"", "wifi":""}
defaultlabel = ""
values = ["Name", "Powered", "Discoverable", "Pairable"]

status = []
for i in ifaces:
    iface = {"Address":i}
    pairs = subprocess.check_output("bluetoothctl show "+i, shell=True).decode("utf-8").strip().split("\n")
    for pair in pairs:
        if ':' in pair:
            k,v = pair.split(':', maxsplit=1)
            k = k.strip()
            if k in values:
                iface[k] = v.strip()
    status.append(iface)

print(json.dumps(status))
