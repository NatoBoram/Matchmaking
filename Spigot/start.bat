@echo off
:x
	echo Starting the server in 3 seconds...
	ping 127.0.0.1 > nul
	java -jar -d64 spigot.jar nogui
	ping 127.0.0.1 > nul
	cls
	ping 127.0.0.1 > nul
goto x