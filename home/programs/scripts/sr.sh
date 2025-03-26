#!/usr/bin/env bash
currentRateNext=$(mpc status %samplerate%)
err="%samplerate%"
while :
do
	currentRateCurrent=$(mpc status %samplerate%)
	if [ "$currentRateCurrent" = "$err" ];
	then
		pw-metadata -n settings 0 clock.force-rate 0
	fi
	if [ "$currentRateCurrent" != "$currentRateNext" ];
	then
		currentRateNext=$(mpc status %samplerate%)
		pw-metadata -n settings 0 clock.force-rate "$currentRateNext"
	fi

done
