@echo off
verify on
wuauclt /detectnow /updatenow
start mdsched
start sigverif
start chkdsk c: /b
start chkdsk d: /b
net start w32time
w32tm /resync
ipconfig /registerdns
defrag c: /h /u
defrag d: /h /u
dism /online /cleanup-image /checkhealth
dism /online /cleanup-image /scanhealth
dism /online /cleanup-image /restorehealth
dism /online /cleanup-image /spsuperseded /hidesp
dism /online /cleanup-image /startcomponentcleanup /resetbase
sfc /scannow
shutdown /r