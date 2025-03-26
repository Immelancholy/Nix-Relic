#!/usr/bin/env bash
rmpc stop
err="%samplerate%"
pwrate=$(pw-metadata -n settings | grep 'clock.force-rate' | cut -d "'" -f 4)
while :
do
	currentRate=$(mpc status %samplerate%)
	if [ "$currentRate" = "$err" ];
	then
		while [ "$pwrate" != "0" ]; 
		do
			pw-metadata -n settings 0 clock.force-rate 0
			pwrate=$(pw-metadata -n settings | grep 'clock.force-rate' | cut -d "'" -f 4)
		done

	fi
	if [ "$currentRate" != "$pwrate" ];
	then
		pw-metadata -n settings 0 clock.force-rate "$currentRate"
		pwrate=$(pw-metadata -n settings | grep 'clock.force-rate' | cut -d "'" -f 4)
	fi

done
