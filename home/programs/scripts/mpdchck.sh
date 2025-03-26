#!/usr/bin/env bash

while :
do
	state=$(mpc status %state%)
	if [ "$state" = "playing" ];
	then
		uwsm app -- sr.sh
	fi
done
