@echo off
verify on

echo Click on "Check for problems the next time I start my computer".
start /wait /min ping 127.0.0.1
start /wait mdsched

echo Press "Y" then "Enter".
start /wait /min ping 127.0.0.1
start /wait chkdsk c: /r

echo Cick on "Start", then "Ok", then "X".
start /wait /min ping 127.0.0.1
start /wait sigverif

echo Congratulation! Now, let this window run in the background. Do not shutdown the computer.
start /wait /min ping 127.0.0.1

start wuauclt /resetauthorization /detectnow /updatenow
start ipconfig /registerdns

defrag /c /h /u

net start w32time
w32tm /resync

dism /online /cleanup-image /restorehealth
sfc /scannow
dism /online /cleanup-image /spsuperseded /hidesp
dism /online /cleanup-image /startcomponentcleanup /resetbase

shutdown /r
