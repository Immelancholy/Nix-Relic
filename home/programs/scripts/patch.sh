#!/usr/bin/env sh
pkill qpwgraph
cd /home/mela/.config/rncbc.org/ || exit
mv qpwgraph.conf qpwgraph_notuse1.conf
mv qpwgraph_notuse.conf qpwgraph.conf
mv qpwgraph_notuse1.conf qpwgraph_notuse.conf
exec qpwgraph
