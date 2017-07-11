#!/bin/sh
while true; do
	echo Starting the server in 3 seconds...
	sleep 3
	java -jar -d64 spigot.jar nogui
	clear
done