#!/bin/bash

c=`brightnessctl get`
m=`brightnessctl max`

echo $(( c * 100 / m ))
