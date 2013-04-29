#!/bin/sh

CUR=$(grep "level:" /proc/acpi/ibm/fan | awk -F":" '{print $2}' | awk '{print $1}')
if [ "$CUR" = "auto" ]; then
	CUR="8"
fi

SEL=$(zenity --scale --title="Fan speed" --text="Select fan speed" --min-value="0" --max-value="8" --value=$CUR)

if [ "$SEL" -eq "8" ]; then
	SEL="auto"
fi

echo "level $SEL" > /proc/acpi/ibm/fan
