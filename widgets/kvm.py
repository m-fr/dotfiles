import subprocess
import json
import re

width = 2

regex = re.compile(r"""
    \s?                   # leading whitespace
    (?P<id>\d+|-)         # id
    \s+                   # first delimiter
    (?P<name>\w+)         # name
    \s+                   # second delimiter
    (?P<state>(\w+\s?)+)  # state
    \s*                   # trailing whitespaces
    """, re.X)

res = subprocess.check_output("virsh list --all | tail -n +3", shell=True).decode("utf-8").strip().split("\n")

VMs = []
for i in range(width):
    VMs.append([])

ctr = 0
for line in res:
    match = regex.search(line)
    if not match:
        continue
    VMs[ctr%width].append(match.groupdict())
    ctr+=1

print(json.dumps(VMs))

