apps = [["Files",    "", "nemo"],
        ["Browser",  "", "firefox"],
        ["Virtual",  "", "vmware"],
        ["Notes",    "", "obsidian"],
        ["IDE",      "", "codium"],
        ["Terminal", "", "urxvt --chdir \"$HOME\""],
        ["Secrets",  "", "keepass2"],
        ["Mixer",    "", "pavucontrol"]]

width = 5

print('''; generated with app.py
(defwidget app[label action ?tooltip ?class]
    (box
        :class "box"
        (button
            :class {class ?: "icon"}
            :tooltip {tooltip ?: ""}
            :onclick action
            label
        )
    )
)
''')

print('(defwidget apps[]')
print('(box :orientation "v" :space-evenly false :class "apps"')
print('(box :orientation "h" :space-evenly false')
ctr = 1
for i in apps:
    print("(app",
        " :tooltip '", i[0],
        "' :label '", i[1],
        "' :action '", i[2],
        "')", sep='')
    if ctr%width == 0:
        print(')(box :orientation "h" :space-evenly false')
    ctr+=1
print(')))')
