import subprocess
import json

types = ["ethernet", "wifi"]

labels = {"ethernet":"󰈀", "loopback":"󱞭", "wifi":"󰖩", "wifi-p2p":"󱚸"}
defaultlabel = ""

ifaces = subprocess.check_output("nmcli -t device status", shell=True).decode("utf-8").strip().split("\n")

out = []
for i in ifaces:
    info = i.split(":")
    type = info[1].strip()
    if type not in types:
        continue
    ips = []
    iface = {
        "id": info[0].strip(),
        "type": info[1].strip(),
        "name": info[3].strip(),
        "status": info[2].split(" ")[0].strip(),
        "label": labels[type] if type in labels else defaultlabel,
    }
    if iface["status"] == "connected":
        ip = subprocess.check_output("nmcli -t device show " + iface["id"] + " | grep ADDRESS", shell=True).decode("utf-8").strip().split("\n")
        for j in ip:
            ips.append(j.split(":", maxsplit=1)[1])
    iface["ips"] = ips
    rxtx = subprocess.check_output("ip -s -h link show " + iface["id"] + " | tr -s [:blank:] | cut -d' ' -f 2 | grep -E -e '[0-9.]+'", shell=True).decode("utf-8").strip().split("\n")
    iface["rx"] = rxtx[-2]
    iface["tx"] = rxtx[-1]
    out.append(iface)


print(json.dumps(out))
