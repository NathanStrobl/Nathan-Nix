#!/bin/bash

pkill polybar

for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
	MONITOR=$m polybar nate &
done
