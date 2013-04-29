#!/bin/sh

WATT=`cat /sys/class/power_supply/BAT0/power_now`
if [ "$WATT" -lt "10000000" ]; then
	c=3
else
	c=2
fi

NW=$(echo "scale=$c; $WATT / 1000000" | bc -l)
echo $NW"W"
