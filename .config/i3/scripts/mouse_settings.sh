#!/bin/sh

for id in $(xinput list | grep "Mouse" | grep -Po "(?<=id=)[^ \t]+")
do
	echo "updating xinput id=$id"
    xinput --set-prop $id "libinput Accel Speed" -0.80
    xinput --set-prop $id "Coordinate Transformation Matrix" 1, 0, 0, 0, 1, 0, 0, 0, 1
done

