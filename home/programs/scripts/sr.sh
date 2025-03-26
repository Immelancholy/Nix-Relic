#!/usr/bin/env bash
currentRateNext=$(mpc status %samplerate%)
err="%samplerate%"
pwrate=$(pw-metadata -n settings | grep 'clock.force-rate' | cut -d "'" -f 4)
rmpc stop
while :
do
	currentRateCurrent=$(mpc status %samplerate%)
	if [ "$currentRateCurrent" = "$err" ];
	then
		while [ "$pwrate" != "0" ]; 
		do
			pw-metadata -n settings 0 clock.force-rate 0
			pwrate=$(pw-metadata -n settings | grep 'clock.force-rate' | cut -d "'" -f 4)
		done

	fi
	if [ "$currentRateCurrent" != "$currentRateNext" ];
	then
		currentRateNext=$(mpc status %samplerate%)
		pw-metadata -n settings 0 clock.force-rate "$currentRateNext"
	fi

done
