import subprocess

ifaces = subprocess.check_output("nmcli -t device status", shell=True).decode("utf-8").strip().split("\n")

labels = {"ethernet":"", "loopback":"", "wifi":""}
defaultlabel = ""

print('(box :orientation "v" :space-evenly false :class "network box"')
for i in ifaces:
    iface = i.split(":")
    info = ""
    if iface[2] == "connected":
        ip = subprocess.check_output("nmcli -t connection show '"+iface[3]+"' | grep ADDRESS", shell=True).decode("utf-8").strip().split("\n")
        for j in ip:
            info += j.split(":", 1)[1] + "\n"
    print("(if :id '", iface[0],
        "' :type '", labels[iface[1]] if iface[1] in labels else defaultlabel,
        "' :status '", iface[2],
        "' :name '" + iface[3] if iface[3] != "" else "",
        "' :info '" + info.strip() if info != "" else "",
        "' )", sep='')
print(')')
