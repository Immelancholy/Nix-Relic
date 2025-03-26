#!/usr/bin/env bash
pwrate=$(pw-metadata -n settings | grep 'clock.force-rate' | cut -d "'" -f 4)
while :
do
	state=$(mpc status %state%)
	if [ "$state" = "paused" ] || [ "$state" = "stopped" ];
	then
		pw-metadata -n settings 0 clock.force-rate 0
		break
	fi
	currentRate=$(mpc status %samplerate%)

	if [ "$currentRate" != "$pwrate" ];
	then
		pw-metadata -n settings 0 clock.force-rate "$currentRate"
		pwrate=$(pw-metadata -n settings | grep 'clock.force-rate' | cut -d "'" -f 4)
	fi

done
