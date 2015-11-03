@echo off
verify on
net start w32time
w32tm /resync
ipconfig /registerdns
sfc /scannow
dism /online /cleanup-image /restorehealth
pause