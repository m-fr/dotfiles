import subprocess
import json

width = 2

class VM:
    def __init__(self, id, name, state):
        self.id = id
        self.name = name
        self.state = state

class VMEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, VM):
            return {"id": obj.id,
                "name": obj.name,
                "state": obj.state}
        return json.JSONEncoder.default(self, obj)

res = subprocess.check_output("virsh list --all | tail -n +3 | tr -s ' '", shell=True).decode("utf-8").strip().split("\n")

VMs = []
for i in range(width):
    VMs.append([])

ctr = 0
for i in range(len(res)):
    vm = res[i].strip().split(" ")
    VMs[ctr%width].append(VM(id=vm[0], name=vm[1], state=vm[2]))
    ctr+=1

print(json.dumps(VMs, cls=VMEncoder))

