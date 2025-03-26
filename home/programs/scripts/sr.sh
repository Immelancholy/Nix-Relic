#!/usr/bin/env bash
pid=$(pgrep qpwgraph)
pwrate=$(pw-metadata -n settings | grep 'clock.force-rate' | cut -d "'" -f 4)
while :
do
	state=$(mpc status %state%)
	if [ "$state" = "paused" ] || [ "$state" = "stopped" ];
	then
		kill $pid
		pw-metadata -n settings 0 clock.force-rate 0
		uwsm app -- qpwgraph
		hyprctl dispatch exec "[workspace 4 silent]" uwsm app -- qpwgraph
		break
	fi
	currentRate=$(mpc status %samplerate%)

	if [ "$currentRate" != "$pwrate" ];
	then
		kill $pid
		pw-metadata -n settings 0 clock.force-rate "$currentRate"
		pwrate=$(pw-metadata -n settings | grep 'clock.force-rate' | cut -d "'" -f 4)

		uwsm app -- qpwgraph
		hyprctl dispatch exec "[workspace 4 silent]" uwsm app -- qpwgraph

	fi

done
