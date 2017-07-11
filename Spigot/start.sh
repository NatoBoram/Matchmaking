#!/bin/sh
while true; do
	echo Starting the server in 3 seconds...
	sleep 1
	echo Starting the server in 2 seconds...
	sleep 1
	echo Starting the server in 1 second...
	sleep 1
	java -jar -d64 spigot.jar nogui
	echo Server closed. You can now close the terminal.
	sleep 3
	clear
done