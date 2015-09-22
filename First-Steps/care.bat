@echo off
verify on
start mdsched
start sigverif
start chkdsk c: /b
net start w32time
w32tm /resync
ipconfig /registerdns
defrag c: /h /u
sfc /scannow
dism /online /cleanup-image /restorehealth
shutdown /r
