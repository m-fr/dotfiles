import subprocess

vmfolder = "$HOME/vmware"
width = 2

VMs = subprocess.check_output("ls "+vmfolder+"/* | grep -e '.*vmx$' | cut -d'.' -f1", shell=True).decode("utf-8").strip().split("\n")
try:
    active = subprocess.check_output("vmrun -T ws list | grep vmx", shell=True).decode("utf-8").strip().split("\n")
except:
    active = ""
else:
    for i in range(len(active)):
        active[i] = active[i].split("/")[-2]

ctr = 1
print("(box :class 'vmware' :orientation 'v' :space-evenly false")
print("(box :orientation 'h' :space-evenly false")
for vm in VMs:
    if ctr%width == 1:
        print(")(box :orientation 'h' :space-evenly false")
        
    path = vmfolder+"/"+vm+"/"+vm+".vmx"
    if vm in active:
        a = 'true'
        try:
            info = subprocess.check_output("vmrun -T ws getGuestIPAddress \""+path+"\"", shell=True).decode("utf-8").strip()
        except:
            info = ""
    else:
        a = 'false'
        info = ""
    print("(vm :name '", vm,
        "' :path '", path,
        "' :active '", a,
        "' :info '", info,
        "' :var vmToggle", ctr,
        " :varname 'vmToggle", ctr,
        "')", sep='')
    ctr+=1
print("))")
