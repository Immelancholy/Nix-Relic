#!/usr/bin/env bash
pwrate=$(pw-metadata -n settings | grep 'clock.force-rate' | cut -d "'" -f 4)
mapfile -t allowedRates < <( pw-metadata -n settings | grep 'clock.allowed-rates' | cut -d "'" -f 4 | tr -d "[" | tr -d "]" | tr -d , ) 
while :
do
	state=$(mpc status %state%)
	if [ "$state" = "paused" ] || [ "$state" = "stopped" ];
	then
		pid=$(pgrep qpwgraph)
		kill "$pid"
		pw-metadata -n settings 0 clock.force-rate 0
		uwsm app -- qpwgraph
		hyprctl dispatch exec "[workspace 4 silent]" uwsm app -- qpwgraph
		break
	fi
	currentRate=$(mpc status %samplerate%)

	if [ "$currentRate" != "$pwrate" ];
	then
		if [[ " ${allowedRates[*]}" =~ [[:space:]]${currentRate}[[:space:]] ]];
		then
			pid=$(pgrep qpwgraph)
			kill "$pid"
			pw-metadata -n settings 0 clock.force-rate "$currentRate"
			pwrate=$(pw-metadata -n settings | grep 'clock.force-rate' | cut -d "'" -f 4)

			uwsm app -- qpwgraph
			hyprctl dispatch exec "[workspace 4 silent]" uwsm app -- qpwgraph

		elif [ $(( currentRate % 48000 )) -eq 0 ];
		then
			pid=$(pgrep qpwgraph)
			kill "$pid"
			pw-metadata -n settings 0 clock.force-rate 48000
			pwrate=${currentRate}

			uwsm app -- qpwgraph
			hyprctl dispatch exec "[workspace 4 silent]" uwsm app -- qpwgraph

		else
			pid=$(pgrep qpwgraph)
			kill "$pid"
			pw-metadata -n settings 0 clock.force-rate 41000
			pwrate=${currentRate}

			uwsm app -- qpwgraph
			hyprctl dispatch exec "[workspace 4 silent]" uwsm app -- qpwgraph
		fi

	fi

done
