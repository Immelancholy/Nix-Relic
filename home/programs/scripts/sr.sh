#!/usr/bin/env bash
err="%samplerate%"
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
		if [ "$currentRate" = "$err" ];
		then
			while [ "$pwrate" != "0" ]; 
			do
				pw-metadata -n settings 0 clock.force-rate 0
				pwrate=$(pw-metadata -n settings | grep 'clock.force-rate' | cut -d "'" -f 4)
			done
		else
			pw-metadata -n settings 0 clock.force-rate "$currentRate"
			pwrate=$(pw-metadata -n settings | grep 'clock.force-rate' | cut -d "'" -f 4)
		fi
	fi

done
